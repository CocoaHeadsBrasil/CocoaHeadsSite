import Foundation
import Ignite

struct CocoaHeadsEvent {
    let title: String
    let chapter: String
    let date: String
    let city: String
    let url: String
    let imageURL: String
}

extension CocoaHeadsEvent {
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

struct ProximosEventos: StaticPage {
    var title = "Próximos Eventos"
    var path: String = "proximos-eventos"

    let events: [CocoaHeadsEvent] = [
        CocoaHeadsEvent(
            title: "CocoaHeads Blumenau",
            chapter: "CocoaHeads Blumenau by Hello, Swift!",
            date: "16 Julho 2026",
            city: "Blumenau, SC",
            url: "https://luma.com/uxxmdztv",
            imageURL: "/images/bnu.jpeg"
        ),
    ]

    var body: some HTML {
        VStack(alignment: .center, spacing: 40) {
            Text("Próximos Eventos")
                .font(.title1)

            Section {
                ForEach(events) { event in
                    Section {
                        EventCard(event: event)
                    }
                    .`class`("col-12")
                }
            }
            .`class`("row", "g-3")
        }
        .padding()
        .frame(width: .vw(100%), minHeight: .vh(100%))
    }
}
