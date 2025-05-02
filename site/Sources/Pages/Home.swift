import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"

    var body: some HTML {
        HStack(alignment: .center) {
            VStack(alignment: .center, spacing: 30) {
                Image(decorative: "/images/logo.svg")
                    .frame(maxWidth: 200, maxHeight: 200)

                Text("Olá CocoaHeads!")
                    .font(.title1)
                    .foregroundStyle(.white)

                HStack {
                    Link(target: "https://instagram.com/cocoaheadsbr") {
                        "Instagram"
                    }
                    .linkStyle(.button)
                    .role(.success)

                    Link(target: "https://bsky.app/profile/cocoaheads.com.br") {
                        "Bluesky"
                    }
                    .linkStyle(.button)
                    .role(.success)

                    Link(target: "https://www.linkedin.com/company/cocoaheads-brasil") {
                        "LinkedIn"
                    }
                    .linkStyle(.button)
                    .role(.success)
                }

                HStack {
                    IgniteFooter()
                        .margin(.top, .rem(-2))
                }
                .padding(.horizontal)
                .cornerRadius(.px(20))
                .background(.white.opacity(0.6))
            }
        }
        .background(.cocoaHeadsBackground)
        .frame(
            width: .vw(100%),
            height: .vh(100%)
        )
    }
}
