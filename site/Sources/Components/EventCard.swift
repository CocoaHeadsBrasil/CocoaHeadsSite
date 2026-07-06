import Foundation
import Ignite

struct EventCard: HTML {
    let event: CocoaHeadsEvent

    var body: some HTML {
        VStack(alignment: .leading, spacing: 0) {
            Image(event.imageURL, description: event.title)
                .aspectRatio(1080.0 / 1350.0, contentMode: .fill)

            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 12) {
                    CHDateBadge(month: event.monthAbbrev, day: event.dayNumber)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(event.title)
                            .textStyle(.headline)
                        Text(event.city)
                            .textStyle(.subhead)
                    }
                }
                CHBadge(event.chapter)
                Text(event.date)
                    .textStyle(.mono)
                Spacer()
                Link(target: event.url) {
                    "Ver evento"
                }
                .buttonStyle(.tinted)
            }
            .padding()
            .`class`("flex-grow-1")
        }
        .card()
        .`class`("h-100", "overflow-hidden")
    }
}
