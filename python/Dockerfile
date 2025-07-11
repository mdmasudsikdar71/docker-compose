# Use official Python base image
FROM python:3.12-slim

# Set maintainer information
LABEL maintainer="MD Masud Sikdar <masudsikdar85@gmail.com>"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory inside the container
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Install app dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy source code
COPY . .

# Default command — override in docker-compose if needed
CMD ["python", "main.py"]
