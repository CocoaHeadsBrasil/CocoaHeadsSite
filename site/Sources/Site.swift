import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        do {
            var site = CocoaHeadsBRSite()
            try await site.publish()
        } catch {
            print("Build failed: \(error.localizedDescription)")
            exit(1)
        }
    }
}

struct CocoaHeadsBRSite: Site {
    var name = "CocoaHeads Brasil"
    var titleSuffix = " – Olá Mundo!"
    var url = URL(static: "https://www.cocoaheads.com.br")
    var builtInIconsEnabled = true
    var author = "CocoaHeads Brasil"
    var homePage = Home()
    var layout = MainLayout()

    var staticPages: [any StaticPage] {
        var pages: [any StaticPage] = [PrivacyPolicy()]
        pages.append(ProximosEventos())
        return pages
    }
}
