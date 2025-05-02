import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        var site = CocoaHeadsBRSite()

        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
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
}
