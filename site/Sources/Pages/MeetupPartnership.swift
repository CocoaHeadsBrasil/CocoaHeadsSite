import Foundation
import Ignite

struct MeetupPartnership: StaticPage {
    var title = "Proposta de Parceria"
    var path: String = "parceria-meetup"
    var description = "Conheça a maior comunidade de desenvolvimento Apple da América Latina e como funciona uma parceria para meetups"
    var image: URL? = URL(static: "https://www.cocoaheads.com.br/images/parceria/hero.webp")

    // MARK: - Content

    private let stats: [PartnershipStat] = [
        PartnershipStat(number: "100+", label: "cidades ao redor do mundo"),
        PartnershipStat(number: "12+", label: "anos de comunidade no Brasil"),
        PartnershipStat(number: "200+", label: "edições realizadas pelo país"),
        PartnershipStat(number: "7", label: "capítulos ativos no país"),
    ]

    private let comoFunciona: [PartnershipInfoItem] = [
        PartnershipInfoItem(label: "Duração", value: "cerca de 2 a 3 horas, geralmente no início da noite de um dia útil"),
        PartnershipInfoItem(label: "Formato", value: "2 a 3 palestras técnicas, com intervalos para networking"),
        PartnershipInfoItem(label: "Público", value: "desenvolvedores profissionais, estudantes e entusiastas das plataformas Apple"),
        PartnershipInfoItem(label: "Participação", value: "gratuita, com inscrição prévia para controle de acesso"),
        PartnershipInfoItem(label: "Registro", value: "palestras gravadas e publicadas no YouTube da comunidade"),
    ]

    private let precisamos: [String] = [
        "Espaço confortável para receber o público (auditório, sala ou área de eventos)",
        "Projetor ou TV com entrada HDMI/USB-C",
        "Liberação de acesso ao prédio no dia do evento",
        "Nenhum pagamento à organização do CocoaHeads — a parceria não envolve qualquer custo ou repasse financeiro",
    ]

    private let beneficios: [PartnershipBenefit] = [
        PartnershipBenefit(
            icon: "people",
            title: "Networking e talentos",
            description: "Contato direto com desenvolvedores experientes e novos talentos da plataforma Apple — um público dedicado, que sai de casa para aprender e trocar com a comunidade"
        ),
        PartnershipBenefit(
            icon: "broadcast",
            title: "Visibilidade qualificada",
            description: "Sua marca associada ao principal encontro de desenvolvedores Apple do Brasil, diante de um público técnico e engajado"
        ),
        PartnershipBenefit(
            icon: "mic",
            title: "Espaço na agenda",
            description: "Um momento para apresentar sua organização, seus projetos ou oportunidades ao público presente"
        ),
        PartnershipBenefit(
            icon: "heart",
            title: "Comunidade dentro de casa",
            description: "Aproximação genuína com o ecossistema de tecnologia Apple — sem nenhum pagamento à organização do CocoaHeads Brasil"
        ),
    ]

    private let agenda: [PartnershipAgendaItem] = [
        PartnershipAgendaItem(time: "19h00", description: "Credenciamento e boas-vindas"),
        PartnershipAgendaItem(time: "19h30", description: "Abertura + espaço do anfitrião", highlight: "seu momento"),
        PartnershipAgendaItem(time: "19h45", description: "Primeira palestra", highlight: "slot opcional para o anfitrião"),
        PartnershipAgendaItem(time: "20h15", description: "Intervalo para networking e coffee break"),
        PartnershipAgendaItem(time: "20h35", description: "Segunda palestra"),
        PartnershipAgendaItem(time: "21h20", description: "Networking livre"),
        PartnershipAgendaItem(time: "22h00", description: "Encerramento"),
    ]

    private let compromissos: [String] = [
        "Curadoria técnica das palestras e seleção dos palestrantes",
        "Gestão completa das inscrições e comunicação com os participantes",
        "Divulgação do evento (e do anfitrião) nos canais da comunidade",
        "Gravação e publicação do conteúdo no YouTube",
        "Cuidado com o espaço e cumprimento das regras da casa",
        "Código de conduta ativo, garantindo um ambiente respeitoso e inclusivo",
    ]

    // MARK: - Page

    var body: some HTML {
        Section {
            Link("Pular para o conteúdo", target: "#conteudo")
                .class("partnership-skip-link")
            Tag("main") {
                hero
                statistics
                Section {
                    community
                    previousHosts
                }
                .class("partnership-band")
                purpose
                Section {
                    benefits
                    meetupFormat
                    responsibilities
                }
                .class("partnership-band")
                schedule
                contact
            }
            .id("conteudo")
            .attribute("tabindex", "-1")
        }
        .class("partnership-page")
        .attribute("lang", "pt-BR")
    }

    private func action(_ label: String, target: String) -> some InlineElement {
        Link(target: target) {
            Span(label)
        }
        .class("partnership-button", "partnership-button-primary")
    }

    private func photo(_ name: String, description: String, eager: Bool = false) -> some InlineElement {
        Image("/images/parceria/\(name).webp", description: description)
            .attribute("loading", eager ? "eager" : "lazy")
            .attribute("decoding", "async")
            .class("partnership-photo")
    }

    // MARK: - Invitation

    private var hero: some HTML {
        Section {
            Section {
                Text {
                    "CocoaHeads "
                    Span("Brasil").class("partnership-hero-accent")
                }
                .font(.title1)
                Text("Proposta de parceria para meetups")
                    .class("partnership-hero-subtitle")
                Section {
                    action("Vamos conversar?", target: "#contato")
                    Link(target: "#como-funciona") {
                        "Como funciona um meetup"
                        Span().class("bi", "bi-chevron-right").attribute("aria-hidden", "true")
                    }
                    .class("partnership-text-link")
                }
                .class("partnership-hero-actions")
            }
            .class("partnership-hero-copy")

            Section {
                Section {
                    photo("hero", description: "Comunidade CocoaHeads Brasil reunida com a bandeira do Brasil", eager: true)
                }
                .class("partnership-hero-photo")
            }
            .class("partnership-hero-gallery")
        }
        .class("partnership-shell", "partnership-hero")
    }

    private var statistics: some HTML {
        Section {
            ForEach(stats) { stat in
                PartnershipStatCard(stat: stat)
            }
        }
        .class("partnership-shell", "partnership-stats")
        .attribute("aria-label", "A comunidade em números")
    }

    // MARK: - Community

    private var community: some HTML {
        Section {
            Section {
                PartnershipHeading("Quem somos")
                Text("O CocoaHeads é um movimento internacional que reúne desenvolvedores das plataformas Apple em encontros regulares e gratuitos. Presente em mais de 100 cidades ao redor do mundo, o movimento chegou ao Brasil há mais de 12 anos e se tornou a maior comunidade de desenvolvimento Apple da América Latina.")
                    .class("partnership-lead")
                Text("Diferente de outros países, onde cada grupo atua isolado, os capítulos brasileiros são conectados em uma rede nacional: compartilham experiências, palestrantes, conteúdo e boas práticas. Hoje temos capítulos ativos em São Paulo, Campinas, Belo Horizonte, Curitiba, Fortaleza, Blumenau e Porto Alegre — e a rede segue crescendo.")
            }
            Section {
                photo("community", description: "Público reunido durante um evento CocoaHeads")
                Text("Todo o conteúdo apresentado nos eventos é gravado e publicado gratuitamente no canal do CocoaHeads Brasil no YouTube, ampliando o alcance de cada edição para desenvolvedores de todo o país. A comunidade também mantém um aplicativo oficial de código aberto, feito inteiramente em SwiftUI.")
            }
            .class("partnership-community-photo")
        }
        .class("partnership-shell", "partnership-section", "partnership-two-columns")
        .id("comunidade")
    }

    private var previousHosts: some HTML {
        Section {
            Text("Só em São Paulo, já realizamos mais de 74 edições — e, pelo país, nossos eventos já aconteceram em locais como Apple, Itaú, Nubank, Uber, Mercado Livre, Ambev e iFood, entre outros.")
                .class("partnership-host-quote")
        }
        .class("partnership-shell", "partnership-hosts")
    }

    private var purpose: some HTML {
        Section {
            PartnershipHeading("Por que fazemos o que fazemos?")
            Text("O CocoaHeads Brasil existe para compartilhar conhecimento e elevar o nível técnico de todos os desenvolvedores, daqueles que estão começando agora a quem já tem mais de dez anos de estrada. Nosso objetivo é criar oportunidades para que as pessoas construam e fortaleçam laços para se transformar na melhor versão de si mesmas, crescendo juntas a cada encontro.")
            Section {
                photo("speaker", description: "Palestra em andamento durante um CocoaHeads")
                photo("crowd", description: "Plateia acompanhando uma palestra no espaço do anfitrião")
            }
            .class("partnership-community-gallery")
        }
        .class("partnership-shell", "partnership-section", "partnership-two-columns", "partnership-purpose")
    }

    // MARK: - Partnership

    private var benefits: some HTML {
        Section {
            Section {
                PartnershipHeading("Por que receber um CocoaHeads")
                Text("Receber um CocoaHeads é uma forma direta de se conectar com a comunidade de tecnologia da sua região:")
                    .class("partnership-section-intro")
            }
            .class("partnership-section-heading")
            Section {
                ForEach(beneficios) { benefit in
                    PartnershipBenefitCard(benefit: benefit)
                }
            }
            .class("partnership-benefits")
        }
        .class("partnership-shell", "partnership-section")
    }

    private var meetupFormat: some HTML {
        Section {
            Section {
                PartnershipHeading("Como funciona um meetup")
                Text("Nossos encontros seguem um formato simples que foi testado ao longo de mais de uma década:")
                    .class("partnership-lead")
                photo("phone-speaker", description: "Palestra técnica em andamento durante um CocoaHeads")
            }
            Section {
                ForEach(comoFunciona) { item in
                    PartnershipInfoRow(item: item)
                }
                Text("Toda a organização — pauta, palestrantes, inscrições, divulgação e gravação — fica por conta da equipe do CocoaHeads. O anfitrião entra com o espaço.")
                    .class("partnership-format-note")
            }
            .class("partnership-format-details")
        }
        .class("partnership-shell", "partnership-section", "partnership-two-columns", "partnership-format")
        .id("como-funciona")
    }

    private var responsibilities: some HTML {
        Section {
            Section {
                Section {
                    PartnershipHeading("O que precisamos de você")
                    Text("Para receber uma edição do CocoaHeads, precisamos apenas de:")
                    ForEach(precisamos) { text in
                        PartnershipChecklistRow(text: text)
                    }
                    Section {
                        Text {
                            Span().class("bi", "bi-cup-hot").attribute("aria-hidden", "true")
                            " Opcional, mas sempre bem-vindo"
                        }
                        .class("partnership-optional-title")
                        Text("Acesso Wi-Fi para os participantes e coffee break ou água/café para os intervalos de networking. A organização pode buscar parceiros e patrocinadores para viabilizar o coffee break, caso o anfitrião não possa oferecê-lo.")
                    }
                    .class("partnership-optional")
                }
                .class("partnership-responsibility")
                Section {
                    PartnershipHeading("Nossos compromissos")
                    Text("Ao realizar um evento no seu espaço, a organização do CocoaHeads se compromete com:")
                    ForEach(compromissos) { text in
                        PartnershipChecklistRow(text: text)
                    }
                }
                .class("partnership-responsibility", "partnership-responsibility-community")
            }
            .class("partnership-responsibilities")
        }
        .class("partnership-shell", "partnership-section", "partnership-practical")
    }

    private var schedule: some HTML {
        Section {
            Section {
                Section {
                    PartnershipHeading("Agenda de uma edição típica")
                    photo("partner", description: "Palestrante no espaço do anfitrião durante um CocoaHeads")
                }
                Section {
                    ForEach(agenda) { item in
                        CHTimelineRow(time: item.time, text: item.description, badge: item.highlight)
                    }
                }
                .timeline()
            }
            .class("partnership-shell", "partnership-two-columns")
        }
        .class("partnership-schedule")
    }

    // MARK: - Contact

    private var contact: some HTML {
        Section {
            Section {
                Section {
                    Text("Vamos conversar?").font(.title2)
                    Text("CocoaHeads Brasil").font(.title3)
                    Text("Quer receber uma edição do CocoaHeads no seu espaço ou apoiar a comunidade? Fale com a gente.")
                    Section {
                        Link("✉️ contato@cocoaheads.com.br", target: "mailto:contato@cocoaheads.com.br")
                            .class("partnership-button", "partnership-button-primary")
                        Link("🌐 cocoaheads.com.br", target: "https://cocoaheads.com.br")
                        Link("📷 @cocoaheadsbr", target: "https://instagram.com/cocoaheadsbr")
                    }
                    .class("partnership-contact-links")
                }
            }
            .class("partnership-contact-panel")
        }
        .class("partnership-shell", "partnership-contact")
        .id("contato")
    }

}
