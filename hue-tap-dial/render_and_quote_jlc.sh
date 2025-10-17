#!/bin/bash

# Script to render OpenSCAD file to STL and open JLC PCB 3D printing quote page
# Usage: ./render_and_quote_jlc.sh [scad_file]

# Set default file if none provided
SCAD_FILE="${1:-frontplate_v1.scad}"

# Check if OpenSCAD file exists
if [ ! -f "$SCAD_FILE" ]; then
    echo "Error: OpenSCAD file '$SCAD_FILE' not found!"
    exit 1
fi

# Get filename without extension
FILENAME=$(basename "$SCAD_FILE" .scad)
STL_FILE="${FILENAME}.stl"

echo "Rendering $SCAD_FILE to $STL_FILE..."

# Render OpenSCAD file to STL
openscad -o "$STL_FILE" "$SCAD_FILE"

# Check if rendering was successful
if [ $? -eq 0 ]; then
    echo "Successfully rendered $STL_FILE"
    echo "STL file location: $(pwd)/$STL_FILE"

    # Open JLC PCB 3D printing quote page in Safari
    echo "Opening JLC PCB 3D printing quote page in Safari..."
    open -a Safari "https://jlc3dp.com/3d-printing-quote?spm=Jlc3dp.Homepage.1011.d1"

    echo "Please upload the STL file ($STL_FILE) to get your 3D printing quote."

    # Optional: Open the folder containing the STL file in Finder for easy access
    echo "Opening folder containing STL file in Finder..."
    open "$(pwd)"

else
    echo "Error: Failed to render OpenSCAD file!"
    exit 1
fi


