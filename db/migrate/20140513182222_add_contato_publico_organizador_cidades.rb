class AddContatoPublicoOrganizadorCidades < ActiveRecord::Migration
  def change
  	add_column :cidades, :organizador_contato, :string
  end
end
