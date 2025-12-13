#!/bin/bash

# Input check  
if [ $# -ne 1 ]; then
  echo "Usage: $0 tasks.csv"
  exit 1
fi

CSV_FILE="$1"
if [ ! -f "$CSV_FILE" ]; then
  echo "ERROR: CSV file not found"
  exit 1
fi

# Prepare output file names
BASENAME=$(basename "$CSV_FILE" .csv)
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

OUT_CSV="outputs_${BASENAME}.csv"
LOG_FILE="campaign_log_${BASENAME}.txt"
HTML_FILE="${BASENAME}_${TIMESTAMP}.html"
GIF_DIR="gifs"

# Create folders and initialize files
mkdir -p "$GIF_DIR"

echo "Source,OutputGIF,Status" > "$OUT_CSV"
echo "$(date) INFO Campaign started" > "$LOG_FILE"

# Create folders and initialize files
echo "<html><body>" > "$HTML_FILE"
echo "<h1>Campaign Results</h1>" >> "$HTML_FILE"
echo "<table border='1'>" >> "$HTML_FILE"
echo "<tr><th>Source</th><th>GIF</th></tr>" >> "$HTML_FILE"

# Read CSV file safely using awk
awk -F',' 'NR>1 { 
  print $1 "|" $2 "|" $3 "|" $4 
}' "$CSV_FILE" |
while IFS='|' read -r SRC OUT Q N; do

  # Read CSV file safely using awk
  STATUS="FAILED"
  OUT_PATH="$GIF_DIR/$OUT.gif"

  echo "$(date) INFO Processing SRC=$SRC OUT=$OUT Q=$Q N=$N" >> "$LOG_FILE"
  
  # Check if source is a URL or local file
  if [[ "$SRC" == http* ]]; then
    SRC_ARGS=(-u "$SRC")
  else
    if [ ! -f "$SRC" ]; then
      echo "$(date) ERROR Source not found: $SRC" >> "$LOG_FILE"
      echo "$SRC,$OUT_PATH,$STATUS" >> "$OUT_CSV"
      continue
    fi
    SRC_ARGS=(-f "$SRC")
  fi
  
  # Run the reveal_effect script
  ./reveal_effect.sh "${SRC_ARGS[@]}" -q "$Q" -n "$N" -o "$OUT" >>"$LOG_FILE" 2>&1
  RC=$?

  # Run the reveal_effect script
  if [ $RC -eq 0 ] && [ -f "$OUT.gif" ]; then
    mv "$OUT.gif" "$OUT_PATH"
    STATUS="SUCCESS"
    echo "<tr><td><img src='$SRC' width='400'></td><td><img src='$OUT_PATH' width='400'></td></tr>" >> "$HTML_FILE"
  else
    echo "$(date) ERROR Failed task SRC=$SRC" >> "$LOG_FILE"
  fi

  # Run the reveal_effect script
  echo "$SRC,$OUT_PATH,$STATUS" >> "$OUT_CSV"

done

# Run the reveal_effect script
echo "</table></body></html>" >> "$HTML_FILE"
echo "$(date) INFO Campaign finished" >> "$LOG_FILE"

echo "Done."