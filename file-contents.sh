#!/bin/bash

# Check if tree command exists
if ! command -v tree > /dev/null; then
    echo "Error: tree command not found. Please install it."
    exit 1
fi

# Check for exactly one argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 directory"
    exit 1
fi

directory="$1"

# Verify that the argument is a directory
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found."
    exit 1
fi

# Print the tree output
tree "$directory"
echo ""

# Use tree to output the list of files in tree order.
# The -i option prints the full path for each entry,
# and --noreport suppresses the summary report.
while IFS= read -r entry; do
    if [ -f "$entry" ]; then
        # Get the relative path from the specified directory.
        relative=$(realpath --relative-to="$directory" "$entry")
        echo "File $relative:"
        cat "$entry"
        echo ""
    fi
done < <(tree -if --noreport "$directory")

