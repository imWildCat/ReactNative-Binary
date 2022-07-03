#!/usr/bin/env bash

INPUT_FILE_PATH=$1

if [ -f "$INPUT_FILE_PATH" ]; then
  FILE_SIZE=$(stat -f%z "$INPUT_FILE_PATH")
  if [ "$FILE_SIZE" -lt 10485760 ]; then
    echo "File size of $INPUT_FILE_PATH is less than 10M"
    exit 1
  fi
fi

echo "File size of $INPUT_FILE_PATH is larger than 10M, which looks good"
