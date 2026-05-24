import Foundation
import Ignite

struct EventCard: HTML {
    let event: CocoaHeadsEvent

    var body: some HTML {
        VStack(alignment: .leading, spacing: 0) {
            Image(event.imageURL, description: event.title)
                .aspectRatio(1080.0 / 1350.0, contentMode: .fill)

            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .font(.title3)
                        .foregroundStyle(.white)
                    Text(event.chapter)
                        .foregroundStyle(.white.opacity(0.8))
                }
                Text(event.date)
                    .foregroundStyle(.white)
                Text(event.city)
                    .foregroundStyle(.white.opacity(0.8))
                Spacer()
                Link(target: event.url) {
                    "Ver evento"
                }
                .linkStyle(.button)
                .role(.success)
            }
            .padding()
            .`class`("flex-grow-1")
        }
        .background(.white.opacity(0.1))
        .cornerRadius(.px(12))
        .`class`("h-100", "overflow-hidden")
    }
}
