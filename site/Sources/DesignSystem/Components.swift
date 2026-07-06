import Ignite

/// Pill chip with a soft green tint. For chapter names, highlights, tags.
struct CHBadge: HTML {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some HTML {
        Text(text)
            .class("ch-badge")
    }
}

/// 48pt rounded-square calendar badge with month over day.
struct CHDateBadge: HTML {
    let month: String
    let day: String

    var body: some HTML {
        Section {
            Span(month).class("ch-date-month")
            Span(day).class("ch-date-day")
        }
        .class("ch-date-badge")
    }
}

/// Green checkmark for checklist rows.
struct CHChecklistMark: HTML {
    var body: some HTML {
        Text("✓")
            .class("ch-check")
    }
}

/// One stop on a `timeline()`: mono time column, dot on the connecting rail,
/// description with an optional badge. The rail and the hollow final dot are
/// drawn by the container, so rows must be direct children of a `timeline()`.
struct CHTimelineRow: HTML {
    let time: String
    let text: String
    let badge: String?

    init(time: String, text: String, badge: String? = nil) {
        self.time = time
        self.text = text
        self.badge = badge
    }

    var body: some HTML {
        Section {
            Span(time)
                .class("ch-timeline-time")

            Section {}
                .class("ch-timeline-rail")

            Section {
                Span(text)
                if let badge {
                    CHBadge(badge)
                }
            }
            .class("ch-timeline-content")
        }
        .class("ch-timeline-row")
    }
}

extension HTML {
    /// Vertical timeline container for `CHTimelineRow`s. Connects the dots
    /// with a soft green rail and hollows out the last stop.
    func timeline() -> some HTML {
        `class`("ch-timeline")
    }
}
