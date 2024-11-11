#!/bin/bash

# Ensure a task description is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <task_description>"
  exit 1
fi

# Escape special characters in the task description for safe usage in bash
task_description=$(printf '%q' "$1")

# Call the LLM function and save output to a file
output_file="src/generated_code.go"

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



llm_generate "$task_description" > "$output_file"

# Validate the generated code
if grep -q "package" "$output_file"; then
  echo "Code successfully generated and saved to $output_file"
else
  echo "Invalid code output detected. Please check the LLM response."
fi

