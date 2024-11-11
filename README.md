# Add this function to your shell profile (e.g., ~/.bashrc or ~/.zshrc)
llm_generate() {
  local prompt="$1"
  curl -s -X POST http://localhost:11434/api/generate \
    -H "Content-Type: application/json" \
    -d "{
          \"model\": \"llama3.2\",
          \"prompt\": \"$prompt\",
          \"stream\": false
        }" | jq -r '.response'
}

# Reload your shell configuration
source ~/.bashrc

# Use the function to send a prompt
llm_generate "Write a Go function that reverses a string."

