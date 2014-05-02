json.array!(@cidades) do |cidade|
  json.extract! cidade, :id, :cidade, :estado, :organizador, :organizador_email, :website, :github, :twitter, :facebook, :published
  json.url cidade_url(cidade, format: :json)
end
