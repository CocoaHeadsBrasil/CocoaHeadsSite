import Foundation
import Ignite

struct PrivacyPolicy: StaticPage {
    var title = "Política de Privacidade"
    var path: String = "app-privacy-policy"

    var body: some HTML {
        VStack(spacing: 20) {
            Text("Política de Privacidade")
                .font(.title1)
                .padding(.bottom, 20)

            VStack(alignment: .leading, spacing: 15) {
                Section {
                    Text("Sua privacidade é importante para nós. Este aplicativo não coleta, armazena ou compartilha dados pessoais ou informações de uso.")
                }
                .padding(.bottom, 10)

                Section {
                    Text("Quais Informações Coletamos")
                        .font(.title2)

                    Text("Não coletamos nenhuma informação pessoal, estatísticas de uso ou dados do dispositivo.")
                }
                .padding(.bottom, 10)

                Section {
                    Text("Serviços de Terceiros")
                        .font(.title2)

                    Text("Este aplicativo não utiliza serviços de terceiros que coletem ou processem seus dados.")
                }
                .padding(.bottom, 10)

                Section {
                    Text("Alterações nesta Política")
                        .font(.title2)

                    Text("Se nossas práticas de privacidade mudarem, atualizaremos esta política e informaremos você adequadamente.")
                }
                .padding(.bottom, 10)

                Section {
                    Text("Contato")
                        .font(.title2)

                    Text("Se você tiver alguma dúvida sobre esta política de privacidade, entre em contato conosco através do email: contato@cocoaheads.com.br")
                }
            }
            .padding()
            .card()

            HStack {
                IgniteFooter()
            }
            .textStyle(.footnote)
        }
        .padding()
        .frame(
            width: .vw(100%),
            minHeight: .vh(100%)
        )
    }
}
