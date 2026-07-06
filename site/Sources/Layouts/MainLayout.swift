import Foundation
import Ignite

struct MainLayout: Layout {
    var body: some Document {
        Head {
            MetaTag(name: "apple-itunes-app", content: "app-id=1180455342, app-clip-bundle-id=com.cocoaheads.conf.baseClip")
            MetaLink(href: "/css/cocoaheads.css", rel: .stylesheet)
        }
        Body {
            content
        }
        .ignorePageGutters()
    }
}
