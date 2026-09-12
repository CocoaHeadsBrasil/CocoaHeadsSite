import Foundation
import Ignite

// MARK: - Data models

struct PartnershipStat {
    let number: String
    let label: String
}

struct PartnershipBenefit {
    let icon: String
    let title: String
    let description: String
}

struct PartnershipInfoItem {
    let label: String
    let value: String
}

struct PartnershipAgendaItem {
    let time: String
    let description: String
    let highlight: String?

    init(time: String, description: String, highlight: String? = nil) {
        self.time = time
        self.description = description
        self.highlight = highlight
    }
}

// MARK: - Section heading

struct PartnershipHeading: HTML {
    let eyebrow: String?
    let title: String

    init(_ title: String, eyebrow: String? = nil) {
        self.title = title
        self.eyebrow = eyebrow
    }

    var body: some HTML {
        Section {
            if let eyebrow {
                Text(eyebrow)
                    .class("partnership-eyebrow")
            }
            Text(title)
                .font(.title2)
        }
        .class("partnership-heading")
    }
}

// MARK: - Stat card

struct PartnershipStatCard: HTML {
    let stat: PartnershipStat

    var body: some HTML {
        Section {
            Text(stat.number)
                .class("partnership-stat-number")
            Text(stat.label)
        }
        .class("partnership-stat")
    }
}

// MARK: - Benefit card

struct PartnershipBenefitCard: HTML {
    let benefit: PartnershipBenefit

    var body: some HTML {
        Section {
            Span().class("bi", "bi-\(benefit.icon)", "partnership-benefit-icon")
                .attribute("aria-hidden", "true")
            Text(benefit.title)
                .font(.title3)
            Text(benefit.description)
        }
        .class("partnership-benefit")
    }
}

// MARK: - Checklist row

struct PartnershipChecklistRow: HTML {
    let text: String

    var body: some HTML {
        Section {
            Span().class("bi", "bi-check2", "partnership-check")
                .attribute("aria-hidden", "true")
            Text(text)
        }
        .class("partnership-checklist-row")
    }
}

// MARK: - Info row (label / value)

struct PartnershipInfoRow: HTML {
    let item: PartnershipInfoItem

    var body: some HTML {
        Section {
            Text(item.label).class("partnership-info-label")
            Text(item.value)
        }
        .class("partnership-info-row")
    }
}
