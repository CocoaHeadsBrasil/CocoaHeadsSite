import Foundation
import Ignite

private let systemFontStack =
    "-apple-system, 'SF Pro Display', 'SF Pro Text', system-ui, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif"
private let monoFontStack =
    "ui-monospace, 'SF Mono', SFMono-Regular, Menlo, Consolas, monospace"

struct CocoaHeadsLightTheme: Theme {
    typealias ResponsiveValues = Ignite.ResponsiveValues<LengthUnit>

    var colorScheme: ColorScheme = .light

    var accent = Color.mata
    var success = Color.mata
    var background = Color(hex: "#FFFFFF")
    var secondaryBackground = Color.groupedSurface
    var primary = Color.label
    var secondary = Color.secondaryLabel
    var tertiary = Color(hex: "#AEAEB2")
    var link = Color.mataInk
    var hoveredLink = Color.mata
    var linkDecoration = TextDecoration.none
    var border = Color(red: 60, green: 60, blue: 67, opacity: 16%)

    var font = Font(name: systemFontStack, sources: [])
    var monospaceFont = Font(name: monoFontStack, sources: [])
    var headingFontWeight = FontWeight.bold

    var h1Size = ResponsiveValues(.px(34))
    var h2Size = ResponsiveValues(.px(28))
    var h3Size = ResponsiveValues(.px(22))
    var h4Size = ResponsiveValues(.px(20))
    var h5Size = ResponsiveValues(.px(17))
    var h6Size = ResponsiveValues(.px(15))
}

struct CocoaHeadsDarkTheme: Theme {
    typealias ResponsiveValues = Ignite.ResponsiveValues<LengthUnit>

    var colorScheme: ColorScheme = .dark

    var accent = Color.mataBright
    var success = Color.mataBright
    var background = Color(hex: "#000000")
    var secondaryBackground = Color(hex: "#1C1C1E")
    var primary = Color(hex: "#FFFFFF")
    var secondary = Color(red: 235, green: 235, blue: 245, opacity: 60%)
    var tertiary = Color(red: 235, green: 235, blue: 245, opacity: 30%)
    var link = Color.mataBright
    var hoveredLink = Color(hex: "#3DDC84")
    var linkDecoration = TextDecoration.none
    var border = Color(red: 84, green: 84, blue: 88, opacity: 60%)

    var font = Font(name: systemFontStack, sources: [])
    var monospaceFont = Font(name: monoFontStack, sources: [])
    var headingFontWeight = FontWeight.bold

    var h1Size = ResponsiveValues(.px(34))
    var h2Size = ResponsiveValues(.px(28))
    var h3Size = ResponsiveValues(.px(22))
    var h4Size = ResponsiveValues(.px(20))
    var h5Size = ResponsiveValues(.px(17))
    var h6Size = ResponsiveValues(.px(15))
}
