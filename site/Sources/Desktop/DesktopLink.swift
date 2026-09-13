/// A dock item or shortcut that leaves the desktop: another page of the site
/// or an external profile.
struct DesktopLink {
    let label: String
    let icon: DesktopIcon
    let url: String

    /// The CocoaHeads Brasil iOS app; the same id as the Smart App Banner in `MainLayout`.
    static let appStore = DesktopLink(
        label: "Baixe o app",
        icon: .symbol("apple", style: "appstore"),
        url: "https://apps.apple.com/app/id1180455342"
    )

    static let partnership = DesktopLink(
        label: "Seja um Anfitrião",
        icon: .symbol("people-fill", style: "hosts"),
        url: "/parceria-meetup"
    )

    static let instagram = DesktopLink(
        label: "Instagram",
        icon: .symbol("instagram", style: "instagram"),
        url: "https://instagram.com/cocoaheadsbr"
    )

    static let linkedin = DesktopLink(
        label: "LinkedIn",
        icon: .symbol("linkedin", style: "linkedin"),
        url: "https://www.linkedin.com/company/cocoaheads-brasil"
    )
}
