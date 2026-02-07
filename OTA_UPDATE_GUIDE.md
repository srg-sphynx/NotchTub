# OTA Update Implementation Guide for NotchTub

## Overview
This document describes what was removed and how to implement OTA (Over-The-Air) updates in the future.

## What Was Removed

### 1. Sparkle Framework Integration
**Files Modified:**
- `DynamicIsland/DynamicIslandApp.swift` - Removed Sparkle import and SPUStandardUpdaterController
- `DynamicIsland/components/Settings/SoftwareUpdater.swift` - Entire file functionality disabled
- `DynamicIsland/components/Settings/SettingsView.swift` - Removed Sparkle import and updater references
- `DynamicIsland/components/Settings/SettingsWindowController.swift` - Removed Sparkle import and updater reference

### 2. External URL References (Info.plist)
Removed keys:
```xml
<key>SUEnableDownloaderService</key>
<key>SUEnableInstallerLauncherService</key>
<key>SUFeedURL</key>
<key>SUPublicEDKey</key>
```

### 3. External URLs (constants.swift)
Commented out:
- `productPage` - GitHub repository link
- `sponsorPage` - Buy Me a Coffee donation link

---

## How to Implement a Custom OTA Mechanism

### Option 1: Re-enable Sparkle Framework
1. Uncomment Sparkle imports in the files listed above
2. Restore `SUFeedURL` in Info.plist with your appcast.xml URL
3. Generate new EdDSA keys using Sparkle's `generate_keys` tool
4. Add `SUPublicEDKey` to Info.plist

### Option 2: Custom Update Server
```swift
// Example: Custom update checker
class UpdateManager {
    static let shared = UpdateManager()
    
    // Your update server endpoint
    private let updateURL = URL(string: "https://your-server.com/api/check-update")!
    
    struct UpdateInfo: Codable {
        let version: String
        let downloadURL: String
        let releaseNotes: String
    }
    
    func checkForUpdates() async throws -> UpdateInfo? {
        let (data, _) = try await URLSession.shared.data(from: updateURL)
        let updateInfo = try JSONDecoder().decode(UpdateInfo.self, from: data)
        
        // Compare with current version
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
        if updateInfo.version > currentVersion {
            return updateInfo
        }
        return nil
    }
    
    func downloadAndInstall(from url: URL) async throws {
        // Download DMG/ZIP to temp directory
        // Mount/Extract and replace app bundle
        // Relaunch app
    }
}
```

### Option 3: App Store Distribution
- Enable App Sandbox entitlements
- Configure App Review metadata
- Use StoreKit for updates

---

## Key Integration Points

### Menu Bar (DynamicIslandApp.swift)
Add update button in `MenuBarExtra`:
```swift
MenuBarExtra(...) {
    Button("Settings") { ... }
    Button("Check for Updates...") {
        // Your update logic here
    }
    Divider()
    ...
}
```

### Settings View (SettingsView.swift)
Add update settings in About section:
```swift
// In About view body
Toggle("Automatically check for updates", isOn: $autoUpdate)
Button("Check Now") {
    // Your update logic
}
```

### Settings Window Controller (SettingsWindowController.swift)
Pass update manager if needed:
```swift
func setUpdateManager(_ manager: UpdateManager) {
    self.updateManager = manager
}
```

---

## Required Entitlements for Network-Based Updates
Add to entitlements file if using custom server:
```xml
<key>com.apple.security.network.client</key>
<true/>
```

---

## File Locations Summary
| File | Purpose |
|------|---------|
| `DynamicIslandApp.swift` | App entry point, menu bar setup |
| `SoftwareUpdater.swift` | Update UI components (currently stubbed) |
| `SettingsView.swift` | Settings window with About section |
| `SettingsWindowController.swift` | Settings window management |
| `Info.plist` | App configuration and update URLs |
| `constants.swift` | External URL constants |
