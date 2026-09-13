import Ignite

/// The site's desktop: every window and link, in dock order.
///
/// Register new windows here. The home page, the dock, the home window's grid
/// and the per-window pages all read from this list.
enum CocoaHeadsDesktop {
    static var windows: [any DesktopWindow] {
        [EventsWindow()]
    }

    static var links: [DesktopLink] {
        [.appStore, .partnership, .instagram, .linkedin]
    }

    /// The desktop, optionally with one more window open and in front.
    static func desktop(opening windowID: String? = nil) -> Desktop {
        Desktop(windows: windows, links: links, opening: windowID)
    }

    /// A page for every window that declares a path, showing the desktop
    /// with that window open.
    static var pages: [any StaticPage] {
        windows.compactMap { window -> (any StaticPage)? in
            guard let path = window.path else { return nil }
            return DesktopWindowPage(title: window.title, path: path, windowID: window.windowID)
        }
    }

    /// Whether `page` renders the desktop: the home page, or one of the
    /// windows' own pages (e.g. `/proximos-eventos/`). `MainLayout` uses this
    /// to scope the desktop-only `<meta>` tags that let the wallpaper bleed
    /// under the device's notch, home indicator, and Safari's own bars —
    /// the rest of the site is a plain light page and shouldn't get them.
    static func isDesktopPage(_ page: PageMetadata) -> Bool {
        var path = page.url.path
        if path.hasSuffix("/") { path.removeLast() }
        if path.isEmpty { return true }
        return windows.contains { $0.path.map { "/\($0)" } == path }
    }
}
