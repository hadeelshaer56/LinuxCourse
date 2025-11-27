if [ $# -ne 3 ]; then
 echo "Usage: $0 folder find replace"
 exit 1
fi

# Dir to search 
DIR=$1
# Find text in all files
FIND=$2
# Replace text with new text 
REPL=$3

# Iterate all text files in $DIR
for file in "$DIR"/*.txt; do
   # Replace all 
   sed -i "s/$FIND/$REPL/g" "$file"
done
