import Ignite

/// The chrome around a `DesktopWindow`: title bar with traffic lights, then
/// the window's own body. The classes, ids and `data-desktop-action`
/// attributes here are the contract with `Assets/js/home-desktop.js`.
struct DesktopWindowFrame: HTML {
    let window: any DesktopWindow
    /// Visible when the page loads.
    let isOpen: Bool
    /// In front when the page loads; the script keeps the class in sync afterwards.
    let isActive: Bool

    var body: some HTML {
        if isOpen {
            frame
        } else {
            frame.attribute("hidden")
        }
    }

    private var frame: some HTML {
        Section {
            Section {
                Section {
                    control("Fechar janela", action: "close", icon: "x")
                    control("Minimizar janela", action: "minimize", icon: "dash")
                    control("Ampliar janela", action: "maximize", icon: "arrows-angle-expand")
                }
                .class("desktop-window-controls")
                Span(window.title).class("desktop-window-title")
            }
            .class("desktop-title-bar")
            Section {
                AnyHTML(window)
            }
            .class("desktop-window-content")
            .attribute("tabindex", "-1")
        }
        .class(classes)
        .id(window.windowID)
        .attribute("aria-label", window.title)
    }

    private var classes: String {
        var classes = ["desktop-window"]
        if window.scrolls { classes.append("desktop-window-scroll") }
        if isActive { classes.append("is-active") }
        return classes.joined(separator: " ")
    }

    private func control(_ label: String, action: String, icon: String) -> some HTML {
        Tag("button") {
            Span().class("bi", "bi-\(icon)").attribute("aria-hidden", "true")
        }
        .attribute("type", "button")
        .attribute("aria-label", label)
        .attribute("title", label)
        .attribute("data-desktop-action", action)
        .class("desktop-window-control", "desktop-control-\(action)")
    }
}
