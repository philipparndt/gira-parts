#!/bin/bash

# Script to render OpenSCAD files to PNG images
# Usage: ./render_images.sh

echo "Rendering OpenSCAD files to PNG images..."

# Check if OpenSCAD is available
if ! command -v openscad &> /dev/null; then
    echo "Error: OpenSCAD is not installed or not in PATH"
    echo "Please install OpenSCAD: https://openscad.org/downloads.html"
    exit 1
fi

# Create images directory if it doesn't exist
mkdir -p images

# Render backplate_v1.scad to PNG
if [ -f "backplate_v1.scad" ]; then
    echo "Rendering backplate_v1.scad..."
    openscad --render --colorscheme=Tomorrow --imgsize=800,600 -o images/backplate_v1.png backplate_v1.scad
    if [ $? -eq 0 ]; then
        echo "✓ backplate_v1.png created successfully"
    else
        echo "✗ Failed to render backplate_v1.scad"
    fi
else
    echo "Warning: backplate_v1.scad not found"
fi

# Render frontplate_v1.scad to PNG
if [ -f "frontplate_v1.scad" ]; then
    echo "Rendering frontplate_v1.scad..."
    openscad --render --colorscheme=Tomorrow --imgsize=800,600 -o images/frontplate_v1.png frontplate_v1.scad
    if [ $? -eq 0 ]; then
        echo "✓ frontplate_v1.png created successfully"
    else
        echo "✗ Failed to render frontplate_v1.scad"
    fi
else
    echo "Warning: frontplate_v1.scad not found"
fi

echo "Done! PNG images saved in the 'images' directory."
