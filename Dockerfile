# Use stable Python (NOT latest)
FROM python:3.11-slim

# Prevent Python cache issues + ensure logs show in Render
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set workdir first (clean structure)
WORKDIR /app

# System dependencies (needed for tgcrypto, pymongo builds, etc.)
RUN apt-get update -y && apt-get install -y \
    build-essential \
    gcc \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip properly
RUN pip install --no-cache-dir --upgrade pip

# Copy only requirements first (better caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy full project
COPY . .

# Run app
CMD ["python3", "-m", "NoxxNetwork"]
