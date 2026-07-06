import Ignite

/// "Mata" surface treatments. The only way pages should style containers.
extension HTML {
    /// Elevated card: theme background, hairline border, 16px radius, soft shadow.
    func card() -> some HTML {
        `class`("ch-card")
    }

    /// Recessed grouped surface (#F2F2F7 light / #1C1C1E dark), 16px radius.
    func groupedSurface() -> some HTML {
        `class`("ch-surface")
    }

    /// The green gradient "wallpaper" panel with white content.
    /// Reserved for accent moments — at most one per page.
    func heroWall() -> some HTML {
        `class`("ch-hero-wall")
    }

    /// Frosted glass surface, for use over `heroWall()`.
    func glass() -> some HTML {
        `class`("ch-glass")
    }

    /// Pull-quote accent: 3px green left border. Compose with `card()`.
    func pullQuote() -> some HTML {
        `class`("ch-pull")
    }

    /// Hairline separators between the container's rows.
    /// Pairs with a 12pt row spacing so the line sits centered in the gap.
    func divided() -> some HTML {
        `class`("ch-divided")
    }
}
