#!/bin/bash

# Run the 'w' command and capture its output
w_output=$(w)

# Use 'awk' to extract the value from the second line's third column
value=$(echo "$w_output" | awk 'NR==2 {print $3}')

# Print the extracted value
echo "Value from the second line's third column: $value"

