#!/bin/bash

# Define the project name and directory
PROJECT_NAME="my-next-app"
PROJECT_DIR="${1:-./subfolder/$PROJECT_NAME}"

# Check if the project directory already exists
if [ -d "$PROJECT_DIR" ]; then
  # Find an available directory name
  SUFFIX=1
  while [ -d "${PROJECT_DIR}_$SUFFIX" ]; do
    SUFFIX=$((SUFFIX + 1))
  done
  PROJECT_DIR="${PROJECT_DIR}_$SUFFIX"
  echo "Directory already exists. Using $PROJECT_DIR instead."
fi

# Create the project directory if it doesn't exist
mkdir -p "$PROJECT_DIR"

# Create the Next.js project with the specified options
npm i -g create-next-app@latest
create-next-app "$PROJECT_DIR" \
  --ts \
  --tailwind \
  --eslint \
  --app \
  --src-dir \
  --use-npm \
  --turbopack \
  --import-alias "@/*" \
  --disable-git \
  --yes && echo "Next.js project created successfully in $PROJECT_DIR"
  npm uninstall -g create-next-app