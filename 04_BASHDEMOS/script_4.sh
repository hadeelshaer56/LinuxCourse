#!/bin/bash

# Required exactly 1 param
if [ $# -ne 1 ]; then
    echo "Usage: $0 folder_path"
    exit 1
fi

#incoming folder path param
DIR=$1
# Current date
DATE=`date +%Y_%m_%d_%H_%M`
# Combined gz file name 
OUT="Backup_`basename $DIR`_${DATE}.tar.gz"
# Execute zip 
tar -czf "$OUT" "$DIR"

echo "Created: $OUT"
ls -l "$OUT"
