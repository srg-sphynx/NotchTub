<p align="center">
  <img src=".github/assets/notchtub-logo.png" alt="NotchTub logo" width="128">
</p>
<h1 align="center">NotchTub</h1>
<p align="center">
  <strong>Dynamic Island for macOS</strong>
</p>
<p align="center">
  <img src="https://img.shields.io/badge/Platform-macOS%2014%2B-blue" alt="macOS 14+"/>
  <img src="https://img.shields.io/badge/Apple%20Silicon-M1%E2%80%93M5-green" alt="Apple Silicon"/>
  <img src="https://img.shields.io/badge/License-GPL%20v3-orange" alt="GPL v3"/>
</p>

---

NotchTub transforms your MacBook's notch into a powerful command surface for media, system monitoring, and productivity tools. Built with native SwiftUI, it integrates seamlessly with macOS while staying out of your way until needed.

<p align="center">
  <img src="DynamicIslandSamples/media.png" alt="NotchTub Media Controls" width="700">
</p>

## ✨ Key Features

### 🎵 Media Controls
- Full media controls for **Apple Music**, **Spotify**, and system-wide playback
- Album art with parallax effects and lyrics display
- Inline sneak peek previews when notch is collapsed
- Floating media control window option

### 📊 System Monitoring
- Real-time CPU, GPU, memory, network, and disk usage
- Per-core CPU tracking with temperature monitoring
- Lightweight stats view in the notch

<p align="center">
  <img src="DynamicIslandSamples/statsmonitor.png" alt="System Stats" width="600">
</p>

### ⏱️ Productivity Tools
- **Timers** with customizable presets and iOS-style countdown
- **Clipboard Manager** with history and quick access
- **Color Picker** for designers and developers
- **Calendar** integration with upcoming events

<p align="center">
  <img src="DynamicIslandSamples/colorpickerpanel.png" alt="Color Picker" width="400">
  <img src="DynamicIslandSamples/clipboardpanel.png" alt="Clipboard Manager" width="400">
</p>

### 🔔 Live Activities
- Screen recording indicator
- Do Not Disturb / Focus mode status
- Privacy indicators (camera, microphone)
- Caps Lock status with customizable tint
- Battery and charging status

### 🔒 Lock Screen Widgets
- Media playback controls
- Timer countdown display
- Battery and Bluetooth device status
- Weather information (via Open Meteo)

### 🎨 Customization
- Minimalistic and standard UI modes
- Custom idle animations
- Gesture controls for media navigation
- Keyboard shortcuts for all features
- Appearance themes and accent colors

<p align="center">
  <img src="DynamicIslandSamples/dynamicisland-minimalistic.png" alt="Minimalistic Mode" width="600">
</p>

## 📋 Requirements

| Requirement | Details |
|------------|---------|
| **macOS** | 14.0 Sonoma or later (optimized for macOS 15 Sequoia) |
| **Hardware** | MacBook with notch (14"/16" MacBook Pro, M1–M5) |
| **Build** | Xcode 15+ (to compile from source) |
| **Permissions** | Accessibility, Screen Recording, Camera, Calendar, Music |

## 🚀 Installation

### From DMG (Recommended)
1. Download `NotchTub.dmg` from [Releases](https://github.com/srg-sphynx/NotchTub/releases)
2. Open the DMG and drag NotchTub to Applications
3. Launch NotchTub and grant requested permissions
4. Enjoy!

### Build from Source
```bash
git clone https://github.com/srg-sphynx/NotchTub.git
cd NotchTub
open DynamicIsland.xcodeproj
```
Then build and run with **Cmd+R** in Xcode.

## 🎮 Quick Start

1. **Hover** near the notch to expand it
2. **Click** to enter interactive mode
3. Use **tabs** to switch between Media, Stats, Timer, Clipboard, etc.
4. Access **Settings** from the menu bar icon (mountain icon)

### Gesture Controls
- **Two-finger swipe down** → Open notch (when hover disabled)
- **Two-finger swipe up** → Close notch
- **Horizontal swipe** → Previous/Next track (when enabled in settings)

## ⚙️ Settings Overview

| Category | Options |
|----------|---------|
| **General** | Launch at login, menu bar visibility, gesture controls |
| **Appearance** | UI mode, animations, accent colors, notch width |
| **Media** | Player sources, sneak peek style, floating controls |
| **Stats** | Enable/disable CPU, GPU, memory, network, disk graphs |
| **Live Activities** | Screen recording, Focus, privacy indicators, Caps Lock |
| **Lock Screen** | Widget toggles and positioning |
| **Shortcuts** | Global keyboard shortcuts for all features |

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| Notch not responding | Restart the app; re-grant Accessibility permission |
| Media controls not working | Ensure Music permission is granted; verify player is active |
| Stats showing empty | Enable categories in Settings → Stats |
| Lock screen widgets missing | Check macOS version (15+ recommended for full support) |

## 📜 License

NotchTub is released under the **GNU General Public License v3**. See [LICENSE](LICENSE) for full terms.

## 🙏 Acknowledgments
 
NotchTub is a personal project exploring the possibilities of the MacBook notch and Apple Silicon.
 
---
 
<p align="center">
  <strong>Made for Apple Silicon by srg-sphynx</strong>
</p>

<p align="center">
  <sub>NotchTub • Dynamic Island for macOS</sub>
</p>