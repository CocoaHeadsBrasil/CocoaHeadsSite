class ChangingDescricaoFromTextToStringOnFotos < ActiveRecord::Migration
  def up
  	change_column :fotos, :descricao,  :string
  end
  def down
  	change_column :fotos, :descricao,  :text
  end
end
