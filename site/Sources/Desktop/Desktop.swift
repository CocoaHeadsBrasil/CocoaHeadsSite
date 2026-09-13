import Ignite

/// The macOS-style desktop: menu bar, windows, dock and the script that
/// drives them.
///
/// Windows appear in the dock and in the home window's grid in the order
/// given, followed by `links`. The home window is created here rather than
/// registered, because it lists every other shortcut.
struct Desktop: HTML {
    let windows: [any DesktopWindow]
    let links: [DesktopLink]
    /// A window to open in front on load, besides those with `opensOnLoad`.
    let opening: String?

    init(windows: [any DesktopWindow], links: [DesktopLink], opening: String? = nil) {
        self.windows = windows
        self.links = links
        self.opening = opening
    }

    private var shortcuts: [DesktopShortcut] {
        windows.map { .window($0, isOpen: isOpen($0)) } + links.map { .link($0) }
    }

    private var home: HomeWindow {
        HomeWindow(shortcuts: shortcuts)
    }

    private var allWindows: [any DesktopWindow] {
        let first: [any DesktopWindow] = [home]
        return first + windows
    }

    private var frontWindowID: String? {
        opening ?? allWindows.first { $0.opensOnLoad }?.windowID
    }

    private func isOpen(_ window: any DesktopWindow) -> Bool {
        window.opensOnLoad || window.windowID == opening
    }

    var body: some HTML {
        // A separate, fixed, full-viewport layer for the wallpaper, rendered as a
        // sibling of `.desktop-page` rather than nested inside it. `.desktop-page`
        // itself is sized to 100svh so its grid lays out the menu bar, workspace and
        // dock safely, but that unit can fall short of the true edge-to-edge screen
        // in Safari; more importantly, `.desktop-page` also has `overflow: clip`,
        // which clips `position: fixed` descendants to its own (possibly short) box
        // even though `fixed` positions them relative to the viewport — so the
        // backdrop has to live outside it to actually bleed under the notch and
        // home indicator.
        Section {}.class("desktop-backdrop")
        Section {
            Link("Pular para os links", target: "#links")
                .class("desktop-skip-link")
            DesktopMenuBar()
            Tag("main") {
                ForEach(allWindows) { window in
                    DesktopWindowFrame(
                        window: window,
                        isOpen: isOpen(window),
                        isActive: window.windowID == frontWindowID
                    )
                }
            }
            .class("desktop-workspace")
            dock
            Script(file: "/js/home-desktop.js")
        }
        .class("desktop-page")
        .attribute("lang", "pt-BR")
    }

    private var dock: some HTML {
        Tag("nav") {
            DesktopLauncher(shortcut: .window(home, isOpen: true), placement: .dock)
            Span().class("desktop-dock-divider").attribute("aria-hidden", "true")
            ForEach(shortcuts) { shortcut in
                DesktopLauncher(shortcut: shortcut, placement: .dock)
            }
        }
        .class("desktop-dock")
        .attribute("aria-label", "Dock")
    }
}

/// Brand on the left, clock on the right. Appearance follows the system.
private struct DesktopMenuBar: HTML {
    var body: some HTML {
        Tag("header") {
            Section {
                Image(decorative: "/images/logo.svg")
                    .attribute("width", "23")
                    .attribute("height", "23")
                Span("CocoaHeads Brasil").class("desktop-menu-title")
            }
            .class("desktop-menu-brand")
            Section {
                Tag("time") { Span("Brasil") }
                    .id("desktop-clock")
            }
            .class("desktop-menu-status")
        }
        .class("desktop-menu-bar")
    }
}
