namespace :agendas do
  desc "Limpa todas as agendas vencidas"
  task clean: :environment do
  	Agenda.limpa_agendas
  end
end