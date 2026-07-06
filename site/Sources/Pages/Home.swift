import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"

    var body: some HTML {
        HStack(alignment: .center) {
            VStack(alignment: .center, spacing: 30) {
                VStack(alignment: .center, spacing: 30) {
                    Image(decorative: "/images/logo.svg")
                        .frame(maxWidth: 200, maxHeight: 200)

                    Text("Olá CocoaHeads!")
                        .font(.title1)

                    HStack {
                        Link(target: "/proximos-eventos") {
                            "Próximos Eventos"
                        }
                        .buttonStyle(.onWall)

                        Link(target: "/parceria-meetup") {
                            "Seja um Anfitrião"
                        }
                        .buttonStyle(.glass)

                        Link(target: "https://instagram.com/cocoaheadsbr") {
                            "Instagram"
                        }
                        .buttonStyle(.glass)

                        Link(target: "https://bsky.app/profile/cocoaheads.com.br") {
                            "Bluesky"
                        }
                        .buttonStyle(.glass)

                        Link(target: "https://www.linkedin.com/company/cocoaheads-brasil") {
                            "LinkedIn"
                        }
                        .buttonStyle(.glass)
                    }
                    .`class`("flex-wrap", "justify-content-center")
                }
                .heroWall()

                HStack {
                    IgniteFooter()
                }
                .textStyle(.footnote)
            }
            .padding()
        }
        .frame(
            width: .vw(100%),
            minHeight: .vh(100%)
        )
    }
}
