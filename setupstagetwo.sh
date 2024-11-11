#!/bin/bash

echo "Setting up project environment..."

# Create necessary directories
mkdir -p logs src tests scripts

# Create essential files if they do not exist
touch current_task.txt TODO.md

# Ensure generate_code.sh is executable
chmod +x generate_code.sh

# Create a placeholder src/generated_code.go if not present
if [ ! -f "src/generated_code.go" ]; then
  touch src/generated_code.go
  echo "Created src/generated_code.go"
fi

# Ensure the ollama.curl.sh script is executable
chmod +x ollama.curl.sh

echo "Setup complete. You should be able to use the 'task' command and run scripts successfully."

