import Ignite

/// "Mata" button styles. `link.buttonStyle(.filled)` replaces the old
/// `.linkStyle(.button).role(.success)` pair everywhere.
enum CHButtonStyle {
    /// Solid green, white text. The single primary action on a page.
    case filled
    /// Soft green tint, ink text. Secondary and repeated actions.
    case tinted
    /// Hairline border, ink text. Tertiary actions.
    case bordered
    /// White pill, ink text. Primary action on a `heroWall()` panel.
    case onWall
    /// Translucent frosted pill. Secondary actions on a `heroWall()` panel.
    case glass

    var cssClass: String {
        switch self {
        case .filled: "ch-btn-filled"
        case .tinted: "ch-btn-tinted"
        case .bordered: "ch-btn-bordered"
        case .onWall: "ch-btn-on-wall"
        case .glass: "ch-btn-glass"
        }
    }
}

extension Link {
    func buttonStyle(_ style: CHButtonStyle) -> some InlineElement {
        linkStyle(.button).class(style.cssClass)
    }
}
