import Ignite

/// Upcoming events, shown as the same cards as the events page. The window
/// is also served at `/proximos-eventos` with itself open.
struct EventsWindow: DesktopWindow {
    let windowID = "events-window"
    let title = "Próximos Eventos"
    let icon = DesktopIcon.symbol("calendar-event", style: "calendar")
    let path: String? = "proximos-eventos"
    let scrolls = true

    private let events = CocoaHeadsEvent.upcoming

    var body: some HTML {
        if events.isEmpty {
            Text("Nenhum evento agendado no momento. Volte em breve!")
                .class("desktop-events-empty")
        } else {
            Section {
                ForEach(events) { event in
                    EventCard(event: event)
                }
            }
            .class("desktop-events-grid")
        }
    }
}
