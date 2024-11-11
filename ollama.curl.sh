# Assuming Ollama is running on localhost at the default port 11434
curl -X POST http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{
        "model": "llama3.2",
        "prompt": "Write a Go function that reverses a string.",
        "stream": false
      }'

