class DeleteNomeFromFotos < ActiveRecord::Migration
  def up
  	remove_column :fotos, :nome
  end
  def down
  	add_column :fotos, :nome, :string
  end
end
