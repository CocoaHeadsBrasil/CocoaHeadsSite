class CreateCidades < ActiveRecord::Migration
  def change
    create_table :cidades do |t|
      t.string :cidade
      t.string :estado
      t.string :organizador
      t.string :organizador_email
      t.string :website
      t.string :github
      t.string :twitter
      t.string :facebook
      t.boolean :published

      t.timestamps
    end
  end
end
