import Foundation
import Ignite

struct WorkshopSponsors: StaticPage {
    var title = "Patrocinadores do Workshop"
    var path: String = "workshop-sponsors"

    var body: some HTML {
        VStack(spacing: 30) {
            Text("Patrocinadores do Workshop")
                .font(.title1)
                .foregroundStyle(.white)
                .padding(.bottom, 10)

            Text("Agradecemos aos apps que apoiam nossos workshops.")
                .foregroundStyle(.white)

            HStack(alignment: .center, spacing: 50) {
                sponsorCard(
                    name: "Joguei",
                    icon: "/images/joguei.svg",
                    url: "https://apps.apple.com/us/app/joguei/id6759177147"
                )

                sponsorCard(
                    name: "Amargana",
                    icon: "/images/amargana.svg",
                    url: "https://apps.apple.com/us/app/amargana/id923464810"
                )
            }
            .padding()
            .background(.white.opacity(0.1))
            .cornerRadius(10)

            HStack {
                IgniteFooter()
            }
            .padding(.horizontal)
            .cornerRadius(.px(20))
            .background(.white.opacity(0.6))
        }
        .padding()
        .background(.cocoaHeadsBackground)
        .frame(
            width: .vw(100%),
            minHeight: .vh(100%)
        )
    }

    private func sponsorCard(name: String, icon: String, url: String) -> some HTML {
        Link(target: url) {
            VStack(alignment: .center, spacing: 15) {
                Image(icon, description: "Ícone do app \(name)")
                    .frame(maxWidth: 160, maxHeight: 160)
                    .cornerRadius(.px(32))

                Text(name)
                    .foregroundStyle(.white)
            }
        }
    }
}
