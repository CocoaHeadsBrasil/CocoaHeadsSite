import Ignite

/// The "Mata" type scale. Apply with `.textStyle(_:)` — the only way pages
/// should size text, so the CSS class names never leak into page code.
enum CHTextStyle {
    /// 34pt bold, tight tracking. Page titles.
    case largeTitle
    /// 22pt bold. Section titles.
    case title2
    /// 17pt semibold. Card and row titles.
    case headline
    /// 15pt, secondary color. Supporting copy.
    case subhead
    /// 13pt, secondary color. Fine print, footers.
    case footnote
    /// Monospace 13pt, secondary color. Dates, metadata, code accents.
    case mono
    /// Monospace uppercase, accent ink. Section eyebrows.
    case eyebrow
    /// 34pt bold in accent ink. Stat numbers.
    case statNumber

    var cssClass: String {
        switch self {
        case .largeTitle: "ch-large-title"
        case .title2: "ch-title2"
        case .headline: "ch-headline"
        case .subhead: "ch-subhead"
        case .footnote: "ch-footnote"
        case .mono: "ch-mono"
        case .eyebrow: "ch-eyebrow"
        case .statNumber: "ch-stat-number"
        }
    }
}

extension HTML {
    func textStyle(_ style: CHTextStyle) -> some HTML {
        `class`(style.cssClass)
    }
}

extension MarkupElement where Self: InlineElement {
    func textStyle(_ style: CHTextStyle) -> some InlineElement {
        `class`(style.cssClass)
    }
}
