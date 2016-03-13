# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# usuario root
user = AdminUser.new(:first_name => "Steve", :last_name => "Jobs", :email => "sjobs@cocoaheads.com.br", :username => "sjobs", :password => "sjobsch2014", :password_confirmation => "sjobsch2014").save

# estados da federacao
e = Estado.create(:sigla => 'AC', :nome => "Acre").save
e = Estado.create(:sigla => 'AL', :nome => "Alagoas").save
e = Estado.create(:sigla => 'AM', :nome => "Amazonas").save
e = Estado.create(:sigla => 'AP', :nome => "Amapá").save
e = Estado.create(:sigla => 'BA', :nome => "Bahia").save
e = Estado.create(:sigla => 'CE', :nome => "Ceará").save
e = Estado.create(:sigla => 'DF', :nome => "Distrito Federal").save
e = Estado.create(:sigla => 'ES', :nome => "Espírito Santo").save
e = Estado.create(:sigla => 'GO', :nome => "Goiás").save
e = Estado.create(:sigla => 'MA', :nome => "Maranhão").save
e = Estado.create(:sigla => 'MG', :nome => "Minas Gerais").save
e = Estado.create(:sigla => 'MS', :nome => "Mato Grosso do Sul").save
e = Estado.create(:sigla => 'MT', :nome => "Mato Grosso").save
e = Estado.create(:sigla => 'PA', :nome => "Pará").save
e = Estado.create(:sigla => 'PB', :nome => "Paraíba").save
e = Estado.create(:sigla => 'PE', :nome => "Pernambuco").save
e = Estado.create(:sigla => 'PI', :nome => "Piauí").save
e = Estado.create(:sigla => 'PR', :nome => "Paraná").save
e = Estado.create(:sigla => 'RJ', :nome => "Rio de Janeiro").save
e = Estado.create(:sigla => 'RN', :nome => "Rio Grande do Norte").save
e = Estado.create(:sigla => 'RO', :nome => "Rondônia").save
e = Estado.create(:sigla => 'RR', :nome => "Roraima").save
e = Estado.create(:sigla => 'RS', :nome => "Rio Grande do Sul").save
e = Estado.create(:sigla => 'SC', :nome => "Santa Catarina").save
e = Estado.create(:sigla => 'SE', :nome => "Sergipe").save
e = Estado.create(:sigla => 'SP', :nome => "São Paulo").save
e = Estado.create(:sigla => 'TO', :nome => "Tocantins").save

load(Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb"))