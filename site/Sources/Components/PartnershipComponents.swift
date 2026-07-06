import Foundation
import Ignite

// MARK: - Data models

struct PartnershipStat {
    let number: String
    let label: String
}

struct PartnershipBenefit {
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
        VStack(alignment: .leading, spacing: 6) {
            if let eyebrow {
                Text(eyebrow)
                    .textStyle(.eyebrow)
            }
            Text(title)
                .font(.title2)
        }
    }
}

// MARK: - Stat card

struct PartnershipStatCard: HTML {
    let stat: PartnershipStat

    var body: some HTML {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.number)
                .textStyle(.statNumber)
            Text(stat.label)
                .textStyle(.footnote)
        }
        .padding()
        .card()
        .`class`("h-100")
    }
}

// MARK: - Benefit card

struct PartnershipBenefitCard: HTML {
    let benefit: PartnershipBenefit

    var body: some HTML {
        VStack(alignment: .leading, spacing: 8) {
            Text(benefit.title)
                .textStyle(.headline)
            Text(benefit.description)
                .textStyle(.subhead)
        }
        .padding()
        .card()
        .`class`("h-100")
    }
}

// MARK: - Checklist row

struct PartnershipChecklistRow: HTML {
    let text: String

    var body: some HTML {
        HStack(alignment: .top, spacing: 16) {
            CHChecklistMark()
            Text(text)
        }
    }
}

// MARK: - Info row (label / value)

struct PartnershipInfoRow: HTML {
    let item: PartnershipInfoItem

    var body: some HTML {
        Section {
            Section {
                Text(item.label)
                    .fontWeight(.bold)
            }
            .`class`("col-12", "col-sm-3")

            Section {
                Text(item.value)
                    .textStyle(.subhead)
            }
            .`class`("col-12", "col-sm-9")
        }
        .`class`("row", "g-1")
    }
}
