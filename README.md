# Gira 3D Printed Parts Collection

A collection of 3D-printed parts and adapters for Gira switch systems, including components for both Gira E2 and Gira F100 systems.

## Overview

This project provides various 3D-printed components for Gira smart home systems:

### Gira F100 Components
- **Hue Tap Dial Adapter**: A mechanical adapter that bridges the gap between the popular Philips Hue Tap Dial smart controller and Gira F100 flush-mounted switch systems. The adapter consists of two main components:

- **Frontplate**: Provides the mounting interface and aesthetic integration
- **Backplate**: Ensures secure mechanical connection

### Gira E2 Components
- **Button Components**: Various customizable button designs for Gira E2 system
- **Radio Buttons**: Button designs with integrated icons for media control
- **Blinds Buttons**: Specialized buttons for window blind control
- **Senic Integration**: Additional components for enhanced functionality

## Components

### Compatible Products

#### Gira F100 System
- **[Philips Hue Tap Dial](https://www.philips-hue.com/en-us/p/hue-tap-dial-switch/046677578817)** - Smart wireless controller for Philips Hue lighting
- **[Gira F100](https://partner.gira.com/en/produkte/schalterprogramme/f100.html#cms-anchor-intro)** - Premium flush-mounted switch system
- You need an original Gira blind plate to attach the adapter

#### Gira E2 System
- **[Gira E2](https://partner.gira.com/en/produkte/schalterprogramme/e2.html)** - Modern flush-mounted switch system
- Compatible with various button configurations and smart home integrations

### 3D Printed Parts

#### Gira F100 Parts (`hue-tap-dial/`)
- `frontplate_v1.scad` - Main mounting plate with connector interface
- `backplate_v1.scad` - Rear support structure  
- `backplate_slim_v1.scad` - Slim version backplate
- `parts.scad` - Shared components and utilities
![Frontplate](images/frontplate_v1.png)
![Backplate](images/backplate_v1.png)


#### Gira E2 Parts (`buttons/`)
- `button.scad` - Base button component
- `radio_button.scad` - Media control button with play/stop icons
- `blinds_button.scad` - Window blind control button
- `radio_button_icons1.scad` & `radio_button_icons2.scad` - Additional icon variants

#### Senic E2 Button (`senic/`)
- `gira-senic-full-button.scad` - Full-size Senic button adapter
- `gira-senic-half-button.scad` - Half-size Senic button adapter
- `gira-senic-test.scad` - Test components

## Building

### Prerequisites
- OpenSCAD for rendering the 3D models
- 3D printer capable of printing PLA/PETG

### Rendering Images
To generate preview images of the components:

For Gira F100 parts:
```bash
cd hue-tap-dial
./render_images.sh
```

For Gira E2 button parts:
```bash
cd buttons
./render_radio_buttons.sh
```

This will create PNG/STL previews in the respective directories.

### 3D Printing
1. Open the SCAD files in OpenSCAD
2. Render to STL format (F6 then F7)
3. Print with standard settings:
   - Layer height: 0.2mm
   - Infill: 15%
   - Material: PLA or PETG
   - Supports: As needed for overhangs

## Installation

### Gira F100 + Hue Tap Dial
1. Print both the frontplate and backplate components
2. Remove the existing Gira switch cover
3. Install the adapter components
4. Mount the Hue Tap Dial using the provided mounting system
5. Configure the Hue Tap Dial in the Philips Hue app

### Gira E2 Buttons
1. Print the desired button components
2. Remove the existing Gira E2 button
3. Install the 3D printed button in the switch housing
4. Connect to your smart home system as needed

## License

This project is open source. Please check local regulations regarding modifications to electrical installations.
