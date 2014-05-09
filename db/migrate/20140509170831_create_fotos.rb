class CreateFotos < ActiveRecord::Migration
  def change
    create_table :fotos do |t|
      t.references :agenda
      
      t.string :nome
      t.text :descricao
      t.string :flickr_album_id
      t.boolean :published

      t.timestamps
    end
  end
end
