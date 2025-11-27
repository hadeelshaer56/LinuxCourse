#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 {file}"
  exit 1
fi

FILE="$1"
CHANGETXT="$2"

# basename always reteuns the last file or folder
NAME=$(basename "$FILE")
# f2 => right side
EXT=$(echo "$NAME" | cut -d'.' -f2)
# name of the file | -f1 => left side
BASE=$(echo "$NAME" | cut -d'.' -f1)
NEWNAME="${BASE}_${CHANGETXT}.${EXT}"
DIR=$(dirname "$FILE")
mv "$FILE" "$DIR/$NEWNAME"

echo "Renamed:"
echo "Old: $FILE"
echo "New: $DIR/$NEWNAME"
