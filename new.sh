#!/bin/bash

# This script is used to create a new blog post
# Usage: ./new_post title

lower_title=$(echo "$1" | tr '[:upper:]' '[:lower:]')
fname=$(echo $lower_title | sed -e 's/ /_/g')
header="---\nAuthor: Taha Azzaoui\nDate: $(date)\nTitle: $1\n---\n" 
echo -e $header > $fname.md
