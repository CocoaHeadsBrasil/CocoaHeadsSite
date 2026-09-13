import Ignite

/// A window on the home desktop.
///
/// Conform in its own file under `Desktop/Windows` and register the window in
/// `CocoaHeadsDesktop`. `Desktop` draws the frame, the dock item and the
/// home-window tile, and `Assets/js/home-desktop.js` handles opening, focus
/// and dragging, so a new window needs no script or chrome work of its own.
protocol DesktopWindow: HTML {
    /// Element id of the window; launchers target it through `data-desktop-window`.
    var windowID: String { get }
    /// Shown in the title bar and used as the launcher label.
    var title: String { get }
    var icon: DesktopIcon { get }
    /// Path of a page that shows the desktop with this window open, such as
    /// `proximos-eventos`. Launchers link to it, so the window still opens
    /// without JavaScript and on a modified click. `nil` renders launchers as
    /// buttons and generates no page.
    var path: String? { get }
    /// Whether the window is visible when the page loads.
    var opensOnLoad: Bool { get }
    /// Top-aligned, scrollable content instead of the centered layout.
    var scrolls: Bool { get }
}

extension DesktopWindow {
    var path: String? { nil }
    var opensOnLoad: Bool { false }
    var scrolls: Bool { false }
}
