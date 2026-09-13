import Foundation

struct CocoaHeadsEvent {
    let title: String
    let chapter: String
    let date: String
    let city: String
    let url: String
    let imageURL: String
}

extension CocoaHeadsEvent {
    /// Upcoming events, shown in the desktop's events window and at
    /// /proximos-eventos. Add one entry per event, for example:
    ///
    ///     CocoaHeadsEvent(
    ///         title: "CocoaHeads Blumenau",
    ///         chapter: "CocoaHeads Blumenau by Hello, Swift!",
    ///         date: "16 Julho 2026",
    ///         city: "Blumenau, SC",
    ///         url: "https://luma.com/uxxmdztv",
    ///         imageURL: "/images/bnu.jpeg"
    ///     )
    static let upcoming: [CocoaHeadsEvent] = []

    /// Day extracted from a "27 Maio 2026" style date, for the date badge.
    var dayNumber: String {
        date.split(separator: " ").first.map(String.init) ?? ""
    }

    /// Abbreviated month ("MAI") extracted from the date, for the date badge.
    var monthAbbrev: String {
        let parts = date.split(separator: " ")
        guard parts.count > 1 else { return "" }
        return String(parts[1].prefix(3)).uppercased()
    }
}
