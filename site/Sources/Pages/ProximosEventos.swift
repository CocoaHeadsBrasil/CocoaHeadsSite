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

struct ProximosEventos: StaticPage {
    var title = "Próximos Eventos"
    var path: String = "proximos-eventos"

    let events: [CocoaHeadsEvent] = [
        CocoaHeadsEvent(
            title: "CocoaHeads Blumenau",
            chapter: "CocoaHeads Blumenau by Hello, Swift!",
            date: "27 Maio 2026",
            city: "Blumenau, SC",
            url: "https://luma.com/dmbd9a46",
            imageURL: "/images/bnu.jpeg"
        ),
        CocoaHeadsEvent(
            title: "74º CocoaHeads SP @ OLX",
            chapter: "CocoaHeads SP",
            date: "28 Maio 2026",
            city: "São Paulo, SP",
            url: "https://www.meetup.com/cocoaheadssp/events/314759767/",
            imageURL: "/images/sp.png"
        ),
        CocoaHeadsEvent(
            title: "WWDC Watch Party",
            chapter: "CocoaHeads BH",
            date: "08 Junho 2026",
            city: "Belo Horizonte, MG",
            url: "https://www.sympla.com.br/evento/wwdc-watch-party-bh/3436374",
            imageURL: "/images/bh.jpg"
        ),
    ]

    var body: some HTML {
        VStack(alignment: .center, spacing: 40) {
            Text("Próximos Eventos")
                .font(.title1)
                .foregroundStyle(.white)

            Section {
                ForEach(events) { event in
                    Section {
                        EventCard(event: event)
                    }
                    .`class`("col-12", "col-md-4")
                }
            }
            .`class`("row", "g-3")
        }
        .padding()
        .background(.cocoaHeadsBackground)
        .frame(width: .vw(100%), minHeight: .vh(100%))
    }
}
