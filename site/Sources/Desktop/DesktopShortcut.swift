import Ignite

/// What a dock item or home-window tile points at.
enum DesktopShortcut {
    /// A window, and whether it is open when the page loads.
    case window(any DesktopWindow, isOpen: Bool)
    case link(DesktopLink)

    var label: String {
        switch self {
        case .window(let window, _): window.title
        case .link(let link): link.label
        }
    }

    var icon: DesktopIcon {
        switch self {
        case .window(let window, _): window.icon
        case .link(let link): link.icon
        }
    }
}

/// Renders a shortcut in the dock or in the home window's grid.
///
/// Window shortcuts carry `data-desktop-action="open"` and
/// `data-desktop-window`, which the desktop script uses to open the window in
/// place. Their `href`, when the window has a page, keeps the link working
/// without JavaScript and on modified clicks.
struct DesktopLauncher: HTML {
    enum Placement {
        case dock
        case grid
    }

    let shortcut: DesktopShortcut
    let placement: Placement

    var body: some HTML {
        switch shortcut {
        case .window(let window, let isOpen):
            if let path = window.path {
                Link(target: "/\(path)") { content }
                    .class(itemClass)
                    .attribute("aria-label", window.title)
                    .attribute("aria-controls", window.windowID)
                    .attribute("aria-expanded", isOpen ? "true" : "false")
                    .attribute("data-desktop-action", "open")
                    .attribute("data-desktop-window", window.windowID)
            } else {
                Tag("button") { content }
                    .attribute("type", "button")
                    .attribute("aria-label", "Abrir \(window.title)")
                    .attribute("aria-controls", window.windowID)
                    .attribute("aria-expanded", isOpen ? "true" : "false")
                    .attribute("data-desktop-action", "open")
                    .attribute("data-desktop-window", window.windowID)
                    .class(itemClass)
            }
        case .link(let link):
            Link(target: link.url) { content }
                .class(itemClass)
                .attribute("aria-label", link.label)
        }
    }

    @InlineElementBuilder
    private var content: some InlineElement {
        shortcut.icon.tile(size: placement == .dock ? 56 : 64)
        Span(shortcut.label).class(labelClass)
    }

    private var itemClass: String {
        placement == .dock ? "desktop-dock-item" : "desktop-shortcut"
    }

    private var labelClass: String {
        placement == .dock ? "desktop-dock-tooltip" : "desktop-shortcut-label"
    }
}
