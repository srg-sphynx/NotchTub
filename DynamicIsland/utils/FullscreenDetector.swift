import AppKit
import Combine

class FullscreenDetector: ObservableObject {
    static let shared = FullscreenDetector()
    @Published var isFullscreen: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    
    // Applications attempting to enter fullscreen often wait a moment
    // We poll briefly to catch this state transition reliably
    private let pollingInterval: TimeInterval = 1.0
    
    private init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        // Monitor active application changes
        NSWorkspace.shared.notificationCenter.publisher(for: NSWorkspace.didActivateApplicationNotification)
            .sink { [weak self] _ in
                self?.checkForFullscreen()
            }
            .store(in: &cancellables)
            
        // Also poll periodically as some apps toggle fullscreen without activation events
        timer = Timer.scheduledTimer(withTimeInterval: pollingInterval, repeats: true) { [weak self] _ in
            self?.checkForFullscreen()
        }
    }
    
    func stopMonitoring() {
        cancellables.removeAll()
        timer?.invalidate()
        timer = nil
    }
    
    private func checkForFullscreen() {
        if let mainScreen = NSScreen.main {
            let isFullScreen = mainScreen.frame == mainScreen.visibleFrame
            if self.isFullscreen != isFullScreen {
                 DispatchQueue.main.async {
                     self.isFullscreen = isFullScreen
                 }
            }
        }
    }
}
