import Foundation
import Ignite

struct MainLayout: Layout {
    var body: Document {
        Head {
            MetaTag(name: "apple-itunes-app", content: "app-id=1180455342, app-clip-bundle-id=com.cocoaheads.conf.baseClip")
        }
        Body {
            content
        }
        .ignorePageGutters()
    }
}
