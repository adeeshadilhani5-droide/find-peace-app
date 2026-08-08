FROM python:3.10-slim

# Install build tools needed for ChromaDB
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt-get/lists/*

WORKDIR /app

# Copy requirement file from backend folder
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all files from backend folder
COPY backend/ .

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
