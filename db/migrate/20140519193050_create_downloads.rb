class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.string :titulo
      t.string :url
      t.string :autor
      t.integer :posicao

      t.timestamps
    end
    add_index :downloads, :posicao
  end
end
