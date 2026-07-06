import Foundation
import Ignite

struct MeetupPartnership: StaticPage {
    var title = "Proposta de Parceria"
    var path: String = "parceria-meetup"

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
            title: "Networking e talentos",
            description: "Contato direto com desenvolvedores experientes e novos talentos da plataforma Apple — um público dedicado, que sai de casa para aprender e trocar com a comunidade"
        ),
        PartnershipBenefit(
            title: "Visibilidade qualificada",
            description: "Sua marca associada ao principal encontro de desenvolvedores Apple do Brasil, diante de um público técnico e engajado"
        ),
        PartnershipBenefit(
            title: "Espaço na agenda",
            description: "Um momento para apresentar sua organização, seus projetos ou oportunidades ao público presente"
        ),
        PartnershipBenefit(
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

    // MARK: - Body

    var body: some HTML {
        Section {
            heroImage
            Section {
                readingRow { heroTitle }
                readingRow { quemSomos }
                wideRow { photoMosaic }
                readingRow { porQueFazemosSection }
                readingRow { comoFuncionaSection }
                readingRow { candidPhoto("/images/parceria/phone-speaker.webp", "Palestra técnica em andamento durante um CocoaHeads") }
                readingRow { precisamosSection }
                readingRow { candidPhoto("/images/parceria/community.webp", "Público reunido durante um evento CocoaHeads") }
                readingRow { beneficiosSection }
                readingRow { candidPhoto("/images/parceria/partner.webp", "Palestrante no espaço do anfitrião durante um CocoaHeads") }
                readingRow { agendaSection }
                readingRow { compromissosSection }
                readingRow { contatoSection }
            }
            .`class`("container")
            .padding(.vertical, 56)
        }
        .frame(width: .vw(100%), minHeight: .vh(100%))
    }

    // A row centering its content at readable text width.
    private func readingRow(@HTMLBuilder _ content: () -> some HTML) -> some HTML {
        Section {
            Section {
                content()
            }
            .`class`("col-12", "col-md-10", "col-lg-8", "col-xl-7")
        }
        .`class`("row", "justify-content-center")
        .margin(.bottom, .rem(3.5))
    }

    // A wider row for photo-heavy blocks that should break out past the text width.
    private func wideRow(@HTMLBuilder _ content: () -> some HTML) -> some HTML {
        Section {
            Section {
                content()
            }
            .`class`("col-12", "col-lg-11", "col-xl-10")
        }
        .`class`("row", "justify-content-center")
        .margin(.bottom, .rem(3.5))
    }

    // MARK: - Photos

    // A single event photo, cropped to `ratio` and rounded.
    private func eventPhoto(_ path: String, _ description: String, ratio: Double) -> some HTML {
        Section {
            Image(path, description: description)
                .aspectRatio(ratio, contentMode: .fill)
                .`class`("w-100")
        }
        .cornerRadius(.px(12))
        .`class`("overflow-hidden", "h-100")
    }

    // Full-width candid shot placed between sections.
    private func candidPhoto(_ path: String, _ description: String) -> some HTML {
        eventPhoto(path, description, ratio: 16.0 / 9.0)
    }

    // Four-photo mosaic shown right after "Quem somos".
    private var photoMosaic: some HTML {
        Section {
            Section {
                eventPhoto("/images/parceria/speaker.webp", "Palestra em andamento durante um CocoaHeads", ratio: 4.0 / 3.0)
            }
            .`class`("col-6")

            Section {
                eventPhoto("/images/parceria/crowd.webp", "Plateia acompanhando uma palestra no espaço do anfitrião", ratio: 4.0 / 3.0)
            }
            .`class`("col-6")

            Section {
                eventPhoto("/images/parceria/event.webp", "Palestrante no palco de um auditório", ratio: 4.0 / 3.0)
            }
            .`class`("col-6")

            Section {
                eventPhoto("/images/parceria/another-speaker.webp", "Palestrante durante apresentação", ratio: 4.0 / 3.0)
            }
            .`class`("col-6")
        }
        .`class`("row", "g-3")
    }

    // MARK: - Sections

    // Full-bleed hero banner spanning the entire page width.
    // The image is pre-cropped to the banner ratio (2400×1040).
    private var heroImage: some HTML {
        Section {
            Image("/images/parceria/hero.webp", description: "Comunidade CocoaHeads Brasil reunida com a bandeira do Brasil")
                .`class`("w-100", "d-block")
        }
    }

    // Eyebrow + title, kept at readable text width below the hero banner.
    private var heroTitle: some HTML {
        VStack(alignment: .leading, spacing: 8) {
            Text("PROPOSTA DE PARCERIA PARA MEETUPS")
                .textStyle(.eyebrow)

            Text("CocoaHeads Brasil")
                .font(.title1)
        }
    }

    private var quemSomos: some HTML {
        VStack(alignment: .leading, spacing: 20) {
            PartnershipHeading("Quem somos")

            Text("O CocoaHeads é um movimento internacional que reúne desenvolvedores das plataformas Apple em encontros regulares e gratuitos. Presente em mais de 100 cidades ao redor do mundo, o movimento chegou ao Brasil há mais de 12 anos e se tornou a maior comunidade de desenvolvimento Apple da América Latina.")

            Section {
                ForEach(stats) { stat in
                    Section {
                        PartnershipStatCard(stat: stat)
                    }
                    .`class`("col-6", "col-md-3")
                }
            }
            .`class`("row", "g-3")

            Text("Diferente de outros países, onde cada grupo atua isolado, os capítulos brasileiros são conectados em uma rede nacional: compartilham experiências, palestrantes, conteúdo e boas práticas. Hoje temos capítulos ativos em São Paulo, Campinas, Belo Horizonte, Curitiba, Fortaleza, Blumenau e Porto Alegre — e a rede segue crescendo.")

            Text("Só em São Paulo, já realizamos mais de 74 edições — e, pelo país, nossos eventos já aconteceram em locais como Apple, Itaú, Nubank, Uber, Mercado Livre, Ambev e iFood, entre outros.")
                .font(.title3)
                .padding()
                .card()
                .pullQuote()

            Text("Todo o conteúdo apresentado nos eventos é gravado e publicado gratuitamente no canal do CocoaHeads Brasil no YouTube, ampliando o alcance de cada edição para desenvolvedores de todo o país. A comunidade também mantém um aplicativo oficial de código aberto, feito inteiramente em SwiftUI.")
        }
    }

    private var porQueFazemosSection: some HTML {
        VStack(alignment: .leading, spacing: 20) {
            PartnershipHeading("Por que fazemos o que fazemos?")

            Text("O CocoaHeads Brasil existe para compartilhar conhecimento e elevar o nível técnico de todos os desenvolvedores, daqueles que estão começando agora a quem já tem mais de dez anos de estrada. Nosso objetivo é criar oportunidades para que as pessoas construam e fortaleçam laços para se transformar na melhor versão de si mesmas, crescendo juntas a cada encontro.")
        }
    }

    private var comoFuncionaSection: some HTML {
        VStack(alignment: .leading, spacing: 20) {
            PartnershipHeading("Como funciona um meetup")

            Text("Nossos encontros seguem um formato simples que foi testado ao longo de mais de uma década:")

            VStack(alignment: .leading, spacing: 12) {
                ForEach(comoFunciona) { item in
                    PartnershipInfoRow(item: item)
                }
            }
            .divided()
            .padding()
            .groupedSurface()
            .frame(maxWidth: .percent(100%))

            Text("Toda a organização — pauta, palestrantes, inscrições, divulgação e gravação — fica por conta da equipe do CocoaHeads. O anfitrião entra com o espaço.")
        }
    }

    private var precisamosSection: some HTML {
        VStack(alignment: .leading, spacing: 20) {
            PartnershipHeading("O que precisamos de você")

            Text("Para receber uma edição do CocoaHeads, precisamos apenas de:")

            VStack(alignment: .leading, spacing: 16) {
                ForEach(precisamos) { text in
                    PartnershipChecklistRow(text: text)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Opcional, mas sempre bem-vindo")
                    .textStyle(.headline)
                Text("Acesso Wi-Fi para os participantes e coffee break ou água/café para os intervalos de networking. A organização pode buscar parceiros e patrocinadores para viabilizar o coffee break, caso o anfitrião não possa oferecê-lo.")
                    .textStyle(.subhead)
            }
            .padding()
            .groupedSurface()
        }
    }

    private var beneficiosSection: some HTML {
        VStack(alignment: .leading, spacing: 20) {
            PartnershipHeading("Por que receber um CocoaHeads")

            Text("Receber um CocoaHeads é uma forma direta de se conectar com a comunidade de tecnologia da sua região:")

            Section {
                ForEach(beneficios) { benefit in
                    Section {
                        PartnershipBenefitCard(benefit: benefit)
                    }
                    .`class`("col-12", "col-md-6")
                }
            }
            .`class`("row", "g-3")
        }
    }

    private var agendaSection: some HTML {
        VStack(alignment: .leading, spacing: 20) {
            PartnershipHeading("Agenda de uma edição típica")

            Section {
                ForEach(agenda) { item in
                    CHTimelineRow(time: item.time, text: item.description, badge: item.highlight)
                }
            }
            .timeline()
            .padding(.vertical, 8)
        }
    }

    private var compromissosSection: some HTML {
        VStack(alignment: .leading, spacing: 20) {
            PartnershipHeading("Nossos compromissos")

            Text("Ao realizar um evento no seu espaço, a organização do CocoaHeads se compromete com:")

            VStack(alignment: .leading, spacing: 16) {
                ForEach(compromissos) { text in
                    PartnershipChecklistRow(text: text)
                }
            }
        }
    }

    private var contatoSection: some HTML {
        VStack(alignment: .leading, spacing: 20) {
            Text("Vamos conversar?")
                .font(.title2)

            Text("CocoaHeads Brasil")
                .font(.title3)

            Text("Quer receber uma edição do CocoaHeads no seu espaço ou apoiar a comunidade? Fale com a gente.")

            VStack(alignment: .leading, spacing: 8) {
                Link(target: "mailto:contato@cocoaheads.com.br") {
                    "✉️ contato@cocoaheads.com.br"
                }

                Link(target: "https://cocoaheads.com.br") {
                    "🌐 cocoaheads.com.br"
                }

                Link(target: "https://instagram.com/cocoaheadsbr") {
                    "📷 @cocoaheadsbr"
                }
            }
        }
        .padding(32)
        .heroWall()
    }
}
