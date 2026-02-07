<p align="center">
  <img src=".github/assets/Gemini_Generated_Image_qxorobqxorobqxor.png" alt="NotchTub logo" width="128">
</p>

# NotchTub
## Native Dynamic Interface for macOS

<p align="center">
  <img src="https://img.shields.io/badge/Platform-macOS%2014%2B-blue" alt="macOS 14+"/>
  <img src="https://img.shields.io/badge/Apple%20Silicon-M1--M5-green" alt="Apple Silicon"/>
  <img src="https://img.shields.io/badge/License-GPL%20v3-orange" alt="GPL v3"/>
</p>

---

NotchTub repurposes the MacBook hardware notch into a functional interface for media management, system telemetry, and productivity. Developed in native SwiftUI, the application maintains the macOS design language while providing an interactive overlay for core system functions.

<p align="center">
  <img src="DynamicIslandSamples/media.png" alt="NotchTub Media Controls" width="700">
</p>

## Core Capabilities

### Media Integration
* Support for Apple Music, Spotify, and system-wide playback.
* Visual components including album art parallax and synchronized lyrics.
* Compact sneak peek previews and optional floating control windows.

### System Telemetry
* Real-time monitoring of CPU, GPU, memory, and network activity.
* Per-core processor tracking and thermal status.
* Condensed statistics view optimized for the notch area.

<p align="center">
  <img src="DynamicIslandSamples/statsmonitor.png" alt="System Stats" width="600">
</p>

### Utility Suite
* **Timers:** Preconfigured intervals with iOS style countdown displays.
* **Clipboard:** Persistent history with rapid access.
* **Design:** Integrated color picker for development and design workflows.
* **Schedule:** Calendar synchronization for upcoming events.

<p align="center">
  <img src="DynamicIslandSamples/colorpickerpanel.png" alt="Color Picker" width="400">
  <img src="DynamicIslandSamples/clipboardpanel.png" alt="Clipboard Manager" width="400">
</p>

### System Indicators
* Visual alerts for screen recording and privacy sensors for camera and microphone.
* Status monitoring for Focus modes and Caps Lock.
* Power management including battery health and charging status.

### Lock Screen Enhancements
* Persistent media controls and active timer visibility.
* Peripheral status for connected Bluetooth devices.
* Weather data integration via Open Meteo.

### Customization
* Toggle between minimalistic and standard UI modes.
* Custom idle animations and gesture based navigation.
* Global keyboard shortcuts and configurable accent color themes.

<p align="center">
  <img src="DynamicIslandSamples/dynamicisland-minimalistic.png" alt="Minimalistic Mode" width="600">
</p>

## Technical Specifications

| Requirement | Detail |
|:---|:---|
| **Operating System** | macOS 14.0 or later (Sequoia optimized) |
| **Hardware** | MacBook Pro with notch (M1 through M5) |
| **Architecture** | Native ARM64 |
| **Build Tooling** | Xcode 15 or newer |
| **Permissions** | Accessibility, Screen Recording, Media, Calendar |

## Installation

### Binary Deployment
1. Download the latest DMG from the **Releases** section.
2. Move NotchTub to the **Applications** directory.
3. Launch the application and approve the required system permissions.

### Source Compilation
```bash
git clone [https://github.com/srg-sphynx/NotchTub.git](https://github.com/srg-sphynx/NotchTub.git)
cd NotchTub
open DynamicIsland.xcodeproj
