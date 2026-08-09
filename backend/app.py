import os
import json
import sqlite3
from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv

from langchain_google_genai import GoogleGenerativeAIEmbeddings, ChatGoogleGenerativeAI
from langchain_chroma import Chroma
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from langchain_core.messages import HumanMessage, AIMessage


# 1. Setup Environment & Flask App

load_dotenv()
API_KEY = os.getenv("GOOGLE_API_KEY")

if not API_KEY:
    raise ValueError("GOOGLE_API_KEY missing in .env")

os.environ["GOOGLE_API_KEY"] = API_KEY

app = Flask(__name__)
CORS(app)

DB_PATH = "dhammapada.db"


# 2. SQLite Database Initialization & Helpers

def get_db_connection():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    with get_db_connection() as conn:
        cursor = conn.cursor()
        # Sessions Table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS sessions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        # Messages Table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS messages (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id INTEGER NOT NULL,
                role TEXT NOT NULL,
                content TEXT NOT NULL,
                sources TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (session_id) REFERENCES sessions (id) ON DELETE CASCADE
            )
        ''')
        conn.commit()

init_db()


# 3. LangChain & Model Setup

embeddings = GoogleGenerativeAIEmbeddings(
    model="models/gemini-embedding-001",
    google_api_key=API_KEY
)

vectorstore = Chroma(
    persist_directory="./chroma_db",
    embedding_function=embeddings
)
retriever = vectorstore.as_retriever(search_kwargs={"k": 3})

llm = ChatGoogleGenerativeAI(
    model="gemini-2.5-flash",
    google_api_key=API_KEY,
    temperature=0.4
)

system_prompt = (
    "You are a helpful assistant for the Dhammapada.\n"
    "Use the retrieved verses and conversation history below to answer the user's question.\n"
    "When citing information, ALWAYS append the exact citation directly after the point using "
    "this format: [Chapter: <Chapter Name>, Verse: <Verse Number>].\n"
    "If the answer cannot be found in the context or chat history, state that you don't know.\n\n"
    "Context:\n{context}"
)

prompt = ChatPromptTemplate.from_messages([
    ("system", system_prompt),
    MessagesPlaceholder(variable_name="chat_history"),
    ("human", "{input}"),
])


# 4. Session & Chat API Endpoints


@app.route("/sessions", methods=["GET"])
def get_sessions():
    """Retrieve list of all chat sessions for the sidebar."""
    conn = get_db_connection()
    sessions = conn.execute(
        "SELECT id, title, created_at FROM sessions ORDER BY id DESC"
    ).fetchall()
    conn.close()
    return jsonify([dict(s) for s in sessions]), 200


@app.route("/sessions", methods=["POST"])
def create_session():
    """Create a new chat session."""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO sessions (title) VALUES (?)", ("New Chat",))
    session_id = cursor.lastrowid
    conn.commit()
    conn.close()
    return jsonify({"id": session_id, "title": "New Chat"}), 201


@app.route("/sessions/<int:session_id>", methods=["DELETE"])
def delete_session(session_id):
    """Delete a chat session and all associated messages."""
    conn = get_db_connection()
    conn.execute("DELETE FROM messages WHERE session_id = ?", (session_id,))
    conn.execute("DELETE FROM sessions WHERE id = ?", (session_id,))
    conn.commit()
    conn.close()
    return jsonify({"message": "Session deleted"}), 200


@app.route("/sessions/<int:session_id>/messages", methods=["GET"])
def get_session_messages(session_id):
    """Retrieve message history for a specific session."""
    conn = get_db_connection()
    raw_msgs = conn.execute(
        "SELECT id, role, content, sources FROM messages WHERE session_id = ? ORDER BY id ASC",
        (session_id,)
    ).fetchall()
    conn.close()

    messages = []
    for msg in raw_msgs:
        m_dict = dict(msg)
        m_dict["sources"] = json.loads(m_dict["sources"]) if m_dict["sources"] else []
        messages.append(m_dict)

    return jsonify(messages), 200


@app.route("/chat", methods=["POST"])
def chat():
    try:
        data = request.get_json() or {}
        session_id = data.get("session_id")
        user_query = data.get("query", "").strip()

        if not session_id or not user_query:
            return jsonify({"error": "Missing session_id or query"}), 400

        conn = get_db_connection()

        # Load existing history for this session from SQLite
        db_history = conn.execute(
            "SELECT role, content FROM messages WHERE session_id = ? ORDER BY id ASC",
            (session_id,)
        ).fetchall()

        chat_history = []
        for row in db_history:
            if row["role"] == "user":
                chat_history.append(HumanMessage(content=row["content"]))
            elif row["role"] == "assistant":
                chat_history.append(AIMessage(content=row["content"]))

        # Check if session needs auto-titling from first query
        session_row = conn.execute("SELECT title FROM sessions WHERE id = ?", (session_id,)).fetchone()
        if session_row and session_row["title"] == "New Chat":
            new_title = user_query[:28] + "..." if len(user_query) > 30 else user_query
            conn.execute("UPDATE sessions SET title = ? WHERE id = ?", (new_title, session_id))

        # Retrieve documents from vector store
        docs = retriever.invoke(user_query)
        context_blocks = []
        structured_sources = []

        for doc in docs:
            content = doc.page_content.strip()
            meta = doc.metadata or {}

            chapter = meta.get("chapter", "Unknown Chapter")
            verse = meta.get("verse_number") or meta.get("verse_no") or "N/A"
            theme = meta.get("theme", "General")
            doc_id = meta.get("id", "N/A")

            context_blocks.append(
                f"--- VERSE START ---\n"
                f"ID: {doc_id}\nChapter: {chapter}\nVerse Number: {verse}\nTheme: {theme}\n"
                f"Content: {content}\n--- VERSE END ---"
            )

            structured_sources.append({
                "id": str(doc_id),
                "chapter": str(chapter),
                "verse_number": str(verse),
                "theme": str(theme),
                "text": content
            })

        formatted_context = "\n\n".join(context_blocks)

        # Run model chain
        chain = prompt | llm
        response = chain.invoke({
            "context": formatted_context,
            "chat_history": chat_history,
            "input": user_query
        })

        bot_answer = response.content

        # Save user message & bot answer to SQLite
        conn.execute(
            "INSERT INTO messages (session_id, role, content) VALUES (?, ?, ?)",
            (session_id, "user", user_query)
        )
        conn.execute(
            "INSERT INTO messages (session_id, role, content, sources) VALUES (?, ?, ?, ?)",
            (session_id, "assistant", bot_answer, json.dumps(structured_sources))
        )
        conn.commit()
        conn.close()

        return jsonify({
            "query": user_query,
            "answer": bot_answer,
            "response": bot_answer,
            "sources": structured_sources
        }), 200

    except Exception as e:
        print(f"Error in /chat: {str(e)}")
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)
