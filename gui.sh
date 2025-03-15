#!/bin/bash

# Check if the required argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 {path to open explorer}"
    exit 1
fi

# Resolve the directory from the argument
if [ "$1" == "." ]; then
    dir=$(pwd)  # Get current directory if '.' is passed
else
    dir=$1
fi

# Check if the directory exists
if [ ! -d "$dir" ]; then
    echo "Error: '$dir' is not a valid directory."
    exit 1
fi

# Open the directory in Nautilus
nautilus "$dir" >/dev/null 2>&1 &

echo "Opened Nautilus at: $dir"
