/*
 * NotchApp (DynamicIsland)
 * Copyright (C) 2026 srg-sphynx
 *
 * Modified and adapted for NotchApp (DynamicIsland)
 * See NOTICE for details.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

import Defaults
import MacroVisionKit
import SwiftUI

class FullscreenMediaDetector: ObservableObject {
    static let shared = FullscreenMediaDetector()
    private let detector = FullScreenMonitor.shared
    @ObservedObject private var musicManager = MusicManager.shared
    @MainActor @Published private(set) var fullscreenStatus: [String: Bool] = [:]
    private var notificationTask: Task<Void, Never>?

    private init() {
        setupNotificationObservers()
        Task { await updateFullScreenStatus() }
    }

    private func setupNotificationObservers() {
        notificationTask = Task { @Sendable [weak self] in
            await withTaskGroup(of: Void.self) { group in
                group.addTask {
                    let activeSpaceNotifications = NSWorkspace.shared.notificationCenter.notifications(
                        named: NSWorkspace.activeSpaceDidChangeNotification
                    )
                    for await _ in activeSpaceNotifications {
                        await self?.handleChange()
                    }
                }

                group.addTask {
                    let screenParameterNotifications = NSWorkspace.shared.notificationCenter.notifications(
                        named: NSApplication.didChangeScreenParametersNotification
                    )
                    for await _ in screenParameterNotifications {
                        await self?.handleChange()
                    }
                }
            }
        }
    }

    private func handleChange() async {
        try? await Task.sleep(for: .milliseconds(500))
        await updateFullScreenStatus()
    }

    private func updateFullScreenStatus() async {
        guard Defaults[.enableFullscreenMediaDetection] else {
            let reset = Dictionary(uniqueKeysWithValues: NSScreen.screens.map { ($0.localizedName, false) })
            await MainActor.run {
                if reset != fullscreenStatus {
                    self.fullscreenStatus = reset
                }
            }
            return
        }

        // FullScreenMonitor.shared is an actor — we must await it
        let spaces = await detector.detectFullscreenApps(debug: false)
        let musicBundleID = await MainActor.run { self.musicManager.bundleIdentifier }
        let hideOption = Defaults[.hideNotchOption]

        // Build a screen-name → fullscreen mapping using screen UUIDs
        var newStatus: [String: Bool] = [:]
        for screen in NSScreen.screens {
            // Try to match screen by UUID if possible
            newStatus[screen.localizedName] = spaces.contains { spaceInfo in
                // Check if this space belongs to this screen (match by UUID)
                let screenMatches: Bool
                if let uuid = spaceInfo.screenUUID,
                   let screenNumber = screen.deviceDescription[NSDeviceDescriptionKey("NSScreenNumber")] as? NSNumber {
                    let displayID = CGDirectDisplayID(screenNumber.uint32Value)
                    if let cfUUID = CGDisplayCreateUUIDFromDisplayID(displayID) {
                        let screenUUID = CFUUIDCreateString(nil, cfUUID.takeRetainedValue()) as String
                        screenMatches = screenUUID == uuid
                    } else {
                        screenMatches = true // fallback: treat as match
                    }
                } else {
                    screenMatches = true // fallback: no UUID to compare
                }
                guard screenMatches else { return false }

                // Check apps in this fullscreen space
                let hasMediaApp = spaceInfo.runningApps.contains { bundleID in
                    bundleID != "com.apple.finder" &&
                    (bundleID == musicBundleID || hideOption == .always)
                }
                return hasMediaApp
            }
        }

        await MainActor.run {
            if newStatus != self.fullscreenStatus {
                self.fullscreenStatus = newStatus
                NSLog("✅ Fullscreen status: \(newStatus)")
            }
        }
    }

    deinit {
        notificationTask?.cancel()
        NSWorkspace.shared.notificationCenter.removeObserver(self)
    }
}
