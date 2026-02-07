/*
 * NotchApp (DynamicIsland)
 * Copyright (C) 2026 srg-sphynx
 *
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
import SwiftUI

/// Fullscreen media detection is disabled.
/// To re-enable, add MacroVisionKit package and restore the original implementation.
@MainActor
class FullscreenMediaDetector: ObservableObject {
    static let shared = FullscreenMediaDetector()
    @Published private(set) var fullscreenStatus: [String: Bool] = [:]
    
    private init() {
        // Fullscreen detection disabled - always report false
        let names = NSScreen.screens.map { $0.localizedName }
        fullscreenStatus = Dictionary(uniqueKeysWithValues: names.map { ($0, false) })
    }
}
