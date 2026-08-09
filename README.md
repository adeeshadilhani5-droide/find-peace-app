# 🪷 Find Peace App - Dhammapada Knowledge System

An AI-powered mobile application that delivers verified Dhammapada stanzas and insights using a Retrieval-Augmented Generation (RAG) architecture to eliminate hallucinations.

---

## Key Features
* **Zero-Hallucination Answers:** Uses RAG to ground responses strictly in verified Dhammapada texts.
* **Vector Search:** Fast semantic retrieval using ChromaDB and Sentence-Transformer embeddings.
* **Modern Mobile Interface:** Built with Flutter for a smooth cross-platform user experience.
* **Cloud Architecture:** Hosted backend services on Google Cloud.

---

##  Tech Stack

* **Frontend:** Flutter (Dart)
* **Backend:** Python, Flask REST API
* **Vector Database:** ChromaDB
* **Embeddings & AI:** Sentence-Transformers, LLM / Generative AI
* **Cloud Infrastructure:** Google Cloud Platform

---

##  Project Structure

```text
find-peace-app/
├── backend/      # Python Flask API & ChromaDB RAG Pipeline
└── frontend/     # Flutter Mobile Application Source Code

Quick Start
 Backend Setup

cd backend
python -m venv venv
# Activate virtual environment
# Windows: venv\Scripts\activate, Mac/Linux: source venv/bin/activate
pip install -r requirements.txt
python app.py

Frontend Setup

cd frontend
flutter pub get
flutter run
