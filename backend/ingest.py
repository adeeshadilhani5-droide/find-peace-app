import os
import json
from dotenv import load_dotenv
from langchain_core.documents import Document
from langchain_google_genai import GoogleGenerativeAIEmbeddings
from langchain_chroma import Chroma

# 1. Load API Key
load_dotenv()
API_KEY = os.getenv("GOOGLE_API_KEY")

if not API_KEY:
    raise ValueError("GOOGLE_API_KEY not found in .env")

os.environ["GOOGLE_API_KEY"] = API_KEY

# 2. Load JSON Dataset
JSON_PATH = "dhammapada_dataset.json"

if not os.path.exists(JSON_PATH):
    raise FileNotFoundError(f"Could not find {JSON_PATH}")

with open(JSON_PATH, "r", encoding="utf-8") as f:
    raw_data = json.load(f)

# 3. Build LangChain Documents with Metadata
documents = []
for item in raw_data:
    # Combine verse text and story for search indexing
    text_content = item.get("text", "").strip()
    story_content = item.get("story", "").strip()
    
    full_text = f"{text_content}\n\nStory Context: {story_content}".strip()

    # Create document with full metadata dictionary
    doc = Document(
        page_content=full_text,
        metadata={
            "id": str(item.get("id", "")),
            "chapter": str(item.get("chapter", "Unknown Chapter")),
            "verse_number": str(item.get("verse_number", "N/A")),
            "theme": str(item.get("theme", "General")),
        }
    )
    documents.append(doc)

print(f"Loaded {len(documents)} verses from JSON.")

# 4. Initialize Embeddings and Save to ChromaDB
embeddings = GoogleGenerativeAIEmbeddings(
    model="models/gemini-embedding-001",
    google_api_key=API_KEY
)

VECTOR_DB_DIR = "./chroma_db"

print("Indexing documents into ChromaDB (this may take a moment)...")
vectorstore = Chroma.from_documents(
    documents=documents,
    embedding=embeddings,
    persist_directory=VECTOR_DB_DIR
)

print("✅ Ingestion complete! Vector database updated with full metadata.")