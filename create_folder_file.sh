#!/bin/bash

# Define folder and file paths
FOLDER_PATH="/opt/myfolder"
FILE_PATH="$FOLDER_PATH/hello.txt"

# Create folder if it doesn't exist
mkdir -p $FOLDER_PATH

# Write content to file
echo "Hello World" > $FILE_PATH
