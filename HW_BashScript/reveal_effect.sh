#!/bin/bash
# Default values
START_QUALITY=5
FRAMES=10
SILENT=false

# Parse ARGS 
while [ "$#" -gt 0 ]; do
  case "$1" in
    -f)
      FILE="$2"
      shift 2
      ;;
    -u)
      URL="$2"
      shift 2
      ;;
    -q)
      START_QUALITY="$2"
      shift 2
      ;;
    -n)
      FRAMES="$2"
      shift 2
      ;;
    -o)
      OUTPUT="$2"
      shift 2
      ;;
    -s)
      SILENT=true
      shift
      ;;
    *)
      echo "ERROR: Unknown flag $1"
      exit 1
      ;;
  esac
done

START_QUALITY="${START_QUALITY//$'\r'/}"
FRAMES="${FRAMES//$'\r'/}"
OUTPUT="${OUTPUT//$'\r'/}"
FILE="${FILE//$'\r'/}"
URL="${URL//$'\r'/}"

# must have output
if [ -z "$OUTPUT" ]; then
  echo "ERROR: output file (-o) is required"
  exit 1
fi

# must have source
if [ -z "$FILE" ] && [ -z "$URL" ]; then
  echo "ERROR: must provide -f or -u"
  exit 1
fi

# check if imagemagick is installed
if command -v magick >/dev/null 2>&1; then
  IM="magick"
elif command -v convert >/dev/null 2>&1; then
  IM="convert"
else
  echo "ERROR: ImageMagick not installed"
  exit 1
fi

TEMP_DIR="temp_frames"
mkdir -p "$TEMP_DIR"

SOURCE_IMAGE="source_image.jpg"

if [ -n "$URL" ]; then
  wget -O "$SOURCE_IMAGE" "$URL"
else
  cp "$FILE" "$SOURCE_IMAGE"
fi

# Generate frames
for ((i=1; i<=FRAMES; i++)); do
  SCALE=$(( START_QUALITY + i * (100 / FRAMES) ))

  convert "$SOURCE_IMAGE" \
    -scale ${SCALE}% \
    -scale 100% \
    "$TEMP_DIR/img_$(printf "%02d" $i).jpg"
done

# Create GIF
convert -delay 20 -loop 0 "$TEMP_DIR"/*.jpg "$OUTPUT.gif"

# Cleanup
rm -rf "$TEMP_DIR"
rm -f "$SOURCE_IMAGE"

if [ "$SILENT" = false ]; then
  echo "GIF created: $OUTPUT.gif"
fi