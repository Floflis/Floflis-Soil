#!/bin/bash

w_output=$(w) # Run the 'w' command and capture its output
value=$(echo "$w_output" | awk 'NR==3 {print $3}') # Use 'awk' to extract the value from the second line's third column

cinnamon --replace -d $value
