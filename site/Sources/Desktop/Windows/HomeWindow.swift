import Ignite

/// The window that is open when the page loads: logo, greeting and a grid
/// with a tile for every other window and link on the desktop.
struct HomeWindow: DesktopWindow {
    let shortcuts: [DesktopShortcut]

    let windowID = "community-window"
    let title = "CocoaHeads Brasil"
    let icon = DesktopIcon.image("/images/logo.svg", style: "community")
    let opensOnLoad = true

    var body: some HTML {
        Image(decorative: "/images/logo.svg")
            .attribute("width", "88")
            .attribute("height", "88")
            .class("desktop-community-logo")
        Text("Olá, CocoaHeads!")
            .font(.title1)
        Tag("nav") {
            ForEach(shortcuts) { shortcut in
                DesktopLauncher(shortcut: shortcut, placement: .grid)
            }
        }
        .class("desktop-shortcuts")
        .attribute("aria-label", "Links do CocoaHeads Brasil")
        .attribute("tabindex", "-1")
        .id("links")
    }
}
