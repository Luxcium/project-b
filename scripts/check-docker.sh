#!/bin/bash

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
  echo "Docker is not running. Starting Docker..."
  open --background -a Docker
  # Wait until Docker daemon is running
  while ! docker info > /dev/null 2>&1; do
    sleep 1
  done
  echo "Docker started successfully."
else
  echo "Docker is already running."
fi

# Start the PostgreSQL database using docker-compose
docker-compose up -d
