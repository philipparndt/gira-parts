#!/bin/bash
# Convert and scale Lucide SVGs (stroke-based) into OpenSCAD-compatible filled shapes.
# Tested on Inkscape 1.3+ on macOS.
# Usage: ./convert-and-scale-lucide.sh

# ============================================================================
# CONFIGURATION - Adjust these variables as needed
# ============================================================================
SCALE_FACTOR=1          # 0.8 = 80% of original size (24x24 -> 19.2x19.2)
STROKE_WIDTH=0.75            # Stroke width for the scaled icons (original is 2)

# ============================================================================
# PATHS
# ============================================================================
# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$SCRIPT_DIR/lucide-main/icons"
OUT_DIR="$SCRIPT_DIR/lucide-scaled-0.75"
mkdir -p "$OUT_DIR"

# Calculate scaled dimensions
ORIGINAL_SIZE=24
SCALED_SIZE=$(echo "$ORIGINAL_SIZE * $SCALE_FACTOR" | bc)
VIEWBOX_OFFSET=$(echo "($ORIGINAL_SIZE - $SCALED_SIZE) / 2" | bc -l)

# ============================================================================
# Function to convert a single SVG file
# ============================================================================
convert_svg() {
  local file="$1"
  local base=$(basename "$file")
  local temp_scaled="$OUT_DIR/.tmp_$base"
  local out="$OUT_DIR/$base"
  
  # Check if already converted (and is newer than source)
  if [ -f "$out" ] && [ "$out" -nt "$file" ]; then
    echo "⏭️  Skipping $base (already converted)"
    return 0
  fi
  
  echo "🔄 Processing $base ..."
  
  # Step 1: Scale and adjust stroke width
  sed -e "s/width=\"24\"/width=\"$SCALED_SIZE\"/g" \
      -e "s/height=\"24\"/height=\"$SCALED_SIZE\"/g" \
      -e "s/viewBox=\"0 0 24 24\"/viewBox=\"$VIEWBOX_OFFSET $VIEWBOX_OFFSET $SCALED_SIZE $SCALED_SIZE\"/g" \
      -e "s/stroke-width=\"2\"/stroke-width=\"$STROKE_WIDTH\"/g" \
      -e "s/stroke-width=\"1.5\"/stroke-width=\"$(echo "$STROKE_WIDTH * 0.75" | bc -l)\"/g" \
      -e "s/stroke-width=\"3\"/stroke-width=\"$(echo "$STROKE_WIDTH * 1.5" | bc -l)\"/g" \
      -e "s/stroke-width=\"4\"/stroke-width=\"$(echo "$STROKE_WIDTH * 2" | bc -l)\"/g" \
      "$file" > "$temp_scaled"
  
  # Step 2: Convert strokes to filled paths using Inkscape
  # Inkscape 1.3+ CLI syntax - optimized for speed
  if inkscape "$temp_scaled" \
    --batch-process \
    --export-type=svg \
    --export-filename="$out" \
    --actions="select-all;object-stroke-to-path;selection-ungroup;selection-ungroup;path-union" \
    --without-gui 2>/dev/null; then
    echo "✅ Converted $base (scaled to ${SCALED_SIZE}x${SCALED_SIZE}, stroke-width: $STROKE_WIDTH)"
    rm "$temp_scaled"
  else
    echo "❌ Failed to convert $base"
    rm -f "$temp_scaled"
  fi
}

export -f convert_svg
export OUT_DIR
export SCALED_SIZE
export VIEWBOX_OFFSET
export STROKE_WIDTH

# ============================================================================
# MAIN EXECUTION
# ============================================================================
echo "=========================================="
echo "Lucide Icon Converter & Scaler"
echo "=========================================="
echo "Source directory:    $SRC_DIR"
echo "Output directory:    $OUT_DIR"
echo "Scale factor:        ${SCALE_FACTOR} (${ORIGINAL_SIZE}x${ORIGINAL_SIZE} → ${SCALED_SIZE}x${SCALED_SIZE})"
echo "Stroke width:        $STROKE_WIDTH (original: 2)"
echo "=========================================="
echo

# Check if Inkscape is available
if ! command -v inkscape >/dev/null 2>&1; then
  echo "❌ Error: Inkscape is not installed or not in PATH"
  echo "Please install Inkscape 1.3+ to use this script"
  exit 1
fi

# Check if bc is available (for calculations)
if ! command -v bc >/dev/null 2>&1; then
  echo "❌ Error: bc calculator is not installed"
  echo "Please install bc: brew install bc"
  exit 1
fi

# Check if GNU parallel is available for faster processing
if command -v parallel >/dev/null 2>&1; then
  echo "🚀 Using parallel processing..."
  find "$SRC_DIR" -maxdepth 1 -name "*.svg" | parallel -j8 convert_svg
else
  echo "📝 Processing sequentially (install 'parallel' for faster processing: brew install parallel)"
  for file in "$SRC_DIR"/*.svg; do
    [ -e "$file" ] || continue
    convert_svg "$file"
  done
fi

echo
echo "=========================================="
echo "✅ Conversion complete!"
echo "=========================================="
echo "Converted SVGs saved to: $OUT_DIR"
echo "Total files: $(find "$OUT_DIR" -name "*.svg" -type f | wc -l | tr -d ' ')"
echo "Settings used:"
echo "  - Scale: ${SCALE_FACTOR} (${SCALED_SIZE}x${SCALED_SIZE})"
echo "  - Stroke width: $STROKE_WIDTH"
echo "=========================================="