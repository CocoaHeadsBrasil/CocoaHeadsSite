import Ignite

/// Icon tile for a dock item or shortcut. `style` names a
/// `desktop-icon-<style>` rule in the stylesheet that paints the tile.
enum DesktopIcon {
    /// A Bootstrap icon name, such as `calendar-event`.
    case symbol(String, style: String)
    /// An image path, such as the chapter logo.
    case image(String, style: String)

    func tile(size: Int) -> AnyInlineElement {
        switch self {
        case .symbol(let name, let style):
            AnyInlineElement(
                Span {
                    Span().class("bi", "bi-\(name)")
                }
                .class("desktop-app-icon", "desktop-icon-\(style)")
                .attribute("aria-hidden", "true")
            )
        case .image(let path, let style):
            AnyInlineElement(
                Image(decorative: path)
                    .attribute("width", "\(size)")
                    .attribute("height", "\(size)")
                    .class("desktop-app-icon", "desktop-icon-\(style)")
            )
        }
    }
}
