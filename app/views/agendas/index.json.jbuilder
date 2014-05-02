json.array!(@agendas) do |agenda|
  json.extract! agenda, :id, :horario, :local, :maps, :passbook, :published, :descricao
  json.url agenda_url(agenda, format: :json)
end
