#!/bin/bash

# Convert all ALAC .m4a files to FLAC
# Requirements: ffmpeg

shopt -s nullglob

for file in *.m4a; do
  output="${file%.m4a}.flac"

  # Skip if FLAC already exists
  if [[ -f "$output" ]]; then
    echo "Skipping $file → $output already exists"
    continue
  fi

  echo "Converting: $file → $output"
  ffmpeg -hide_banner -loglevel error -i "$file" -c:a flac -map_metadata 0 "$output"

  if [[ $? -eq 0 ]]; then
    echo "Done: $output"
  else
    echo "Failed to convert: $file"
  fi

  echo
done
