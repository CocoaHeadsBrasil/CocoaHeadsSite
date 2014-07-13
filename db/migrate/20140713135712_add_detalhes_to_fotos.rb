class AddDetalhesToFotos < ActiveRecord::Migration
  def change
  	add_column :fotos, :detalhes, :text
  end
end
