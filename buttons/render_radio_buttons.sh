#!/bin/bash

# Script to render radio button OpenSCAD files to STL and open both in BambuStudio
# Usage: ./render_radio_buttons.sh

# Define the files to render
SCAD_FILES=("radio_button_icons1.scad" "radio_button_icons2.scad" "radio_button.scad")
TMP_DIR="tmp"
STL_FILES=()

# Ensure tmp directory exists
mkdir -p "$TMP_DIR"

echo "Starting rendering process..."

# Render each OpenSCAD file
for SCAD_FILE in "${SCAD_FILES[@]}"; do
    # Check if OpenSCAD file exists
    if [ ! -f "$SCAD_FILE" ]; then
        echo "Error: OpenSCAD file '$SCAD_FILE' not found!"
        continue
    fi

    # Get filename without extension
    FILENAME=$(basename "$SCAD_FILE" .scad)
    STL_FILE="${TMP_DIR}/${FILENAME}.stl"
    
    echo "Rendering $SCAD_FILE to $STL_FILE..."
    
    # Render OpenSCAD file to STL
    openscad -o "$STL_FILE" "$SCAD_FILE"
    
    # Check if rendering was successful
    if [ $? -eq 0 ]; then
        echo "Successfully rendered $STL_FILE"
        STL_FILES+=("$STL_FILE")
    else
        echo "Error: Failed to render $SCAD_FILE!"
    fi
done

# Check if any files were successfully rendered
if [ ${#STL_FILES[@]} -eq 0 ]; then
    echo "Error: No STL files were successfully rendered!"
    exit 1
fi

# Open all STL files in BambuStudio with a single command
if command -v bambu-studio &> /dev/null; then
    echo "Opening ${#STL_FILES[@]} STL files in BambuStudio..."
    bambu-studio "${STL_FILES[@]}"
elif [ -d "/Applications/BambuStudio.app" ]; then
    echo "Opening ${#STL_FILES[@]} STL files in BambuStudio..."
    open -a "BambuStudio" "${STL_FILES[@]}"
else
    echo "BambuStudio not found. Please install BambuStudio or open the following files manually:"
    for STL_FILE in "${STL_FILES[@]}"; do
        echo "  $(pwd)/$STL_FILE"
    done
fi

echo "Rendering process complete!"