import Foundation
import Ignite

struct MainLayout: Layout {
    @Environment(\.page) private var page
    @Environment(\.author) private var author
    @Environment(\.favicon) private var favicon
    @Environment(\.builtInIconsEnabled) private var builtInIconsEnabled

    var body: some Document {
        let isDesktop = CocoaHeadsDesktop.isDesktopPage(page)

        var head = Head {
            // Ignite always hard-codes its own "width=device-width, initial-scale=1"
            // viewport tag with no way to customize or replace just that one line,
            // and there is no reliable way to override it after the fact (a second,
            // competing viewport tag and a script that rewrites the first tag's
            // `content` both failed on a real device: Safari had already committed
            // to the plain viewport by the time either ran). So this reconstructs
            // Ignite's own standard `<head>` by hand for the desktop pages only,
            // swapping in `viewport-fit=cover`, which is what makes
            // env(safe-area-inset-*) resolve to real values instead of 0 in
            // cocoaheads.css, and lets the wallpaper bleed under the notch and
            // home indicator. Kept in sync with what Ignite v0.6.9's
            // `Head.standardHeaders()` emits; re-check this after an Ignite update.
            if isDesktop {
                MetaTag.utf8
                MetaTag(.viewport, content: "width=device-width, initial-scale=1, viewport-fit=cover")

                if page.description.isEmpty == false {
                    MetaTag(name: "description", content: page.description)
                }
                if author.isEmpty == false {
                    MetaTag(name: "author", content: author)
                }
                MetaTag.generator
                Title(page.title)

                MetaLink.standardCSS
                if builtInIconsEnabled == .localBootstrap {
                    MetaLink.iconCSS
                } else {
                    MetaLink.remoteIconCSS
                }
                // Not public on MetaLink, so reconstructed with the same href/rel.
                MetaLink(href: "/css/ignite-core.min.css", rel: .stylesheet)

                MetaLink(href: page.url, rel: .canonical)
                if let favicon {
                    MetaLink(href: favicon, rel: .icon)
                }
                // Matches Site.feedConfiguration's `.default` (RSS only, no JSON/Atom).
                MetaLink(href: "/feed.rss", rel: .alternate)
                    .customAttribute(name: "type", value: "application/rss+xml")
                    .customAttribute(name: "title", value: "RSS Feed")

                // Ignite's own inline auto/light/dark theme switcher, copied
                // verbatim since its source lives in the framework's bundle.
                Script(code: Self.themeSwitchingScript)

                for tag in MetaTag.socialSharingTags() {
                    tag
                }
            }

            MetaTag(name: "apple-itunes-app", content: "app-id=1180455342, app-clip-bundle-id=com.cocoaheads.conf.baseClip")
            MetaLink(href: "/css/cocoaheads.css", rel: .stylesheet)

            if isDesktop {
                // Colors Safari's own toolbar/status bar to match the wallpaper
                // instead of the default white, so there's no seam where the
                // page ends and the browser's chrome begins.
                MetaTag(name: "theme-color", content: "#137566")
                    .customAttribute(name: "media", value: "(prefers-color-scheme: light)")
                MetaTag(name: "theme-color", content: "#0d5950")
                    .customAttribute(name: "media", value: "(prefers-color-scheme: dark)")
            }
        }

        if isDesktop {
            head = head.standardHeadersDisabled()
        }

        return DocumentBuilder.buildBlock(head, Body { content }.ignorePageGutters())
    }

    /// Ignite's `Head.standardHeaders()` builds this from a bundled resource file
    /// that isn't reachable from outside the framework, so it's copied here
    /// verbatim for the desktop pages, which reconstruct their own head by hand.
    private static let themeSwitchingScript = """
    (function() {
        function getThemePreference() {
            return localStorage.getItem('custom-theme') || 'auto';
        }

        function applyTheme(themeID) {
            const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            const lightThemeID = document.documentElement.getAttribute('data-light-theme') || 'light';
            const darkThemeID = document.documentElement.getAttribute('data-dark-theme') || 'dark';
            const actualThemeID = themeID === 'auto' ? (prefersDark ? darkThemeID : lightThemeID) : themeID;

            document.documentElement.setAttribute('data-bs-theme', actualThemeID);
            document.documentElement.setAttribute('data-theme-state', themeID);
        }

        function applySyntaxTheme() {
            const syntaxTheme = getComputedStyle(document.documentElement)
                .getPropertyValue('--syntax-highlight-theme').trim().replace(/"/g, '');

            if (!syntaxTheme) return;

            document.querySelectorAll('link[data-highlight-theme]').forEach(link => {
                link.setAttribute('disabled', 'disabled');
            });

            const themeLink = document.querySelector(`link[data-highlight-theme="${syntaxTheme}"]`);
            if (themeLink) {
                themeLink.removeAttribute('disabled');
            }
        }

        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
            const currentTheme = getThemePreference();
            if (currentTheme === 'auto') {
                applyTheme('auto');
                applySyntaxTheme();
            }
        });

        const savedTheme = getThemePreference();
        applyTheme(savedTheme);
        applySyntaxTheme();
    })();
    """
}
