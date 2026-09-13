import Foundation
import Ignite

struct Home: StaticPage {
    var title = "CocoaHeads Brasil"
    var description = "CocoaHeads Brasil — eventos, parcerias e redes sociais."
    var image: URL? = URL(static: "https://www.cocoaheads.com.br/images/parceria/hero.webp")

    /// Windows and links are registered in `CocoaHeadsDesktop`.
    var body: some HTML {
        CocoaHeadsDesktop.desktop()
    }
}
