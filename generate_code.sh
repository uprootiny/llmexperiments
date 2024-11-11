#!/bin/bash

# Check if a task description is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <task_description>"
  exit 1
fi

# Task description passed as an argument
task_description="$1"

# Call the LLM and save output to a file
output_file="src/generated_code.go"
llm_generate "$task_description" > "$output_file"

# Check if the file was created and contains valid output
if grep -q "package" "$output_file"; then
  echo "Code successfully generated and saved to $output_file"
else
  echo "Invalid code output detected. Please check the LLM response."
fi

