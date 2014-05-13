class AddDescricaoToCidades < ActiveRecord::Migration
  def change
    add_column :cidades, :descricao, :text
  end
end
