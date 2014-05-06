class CreateAgendas < ActiveRecord::Migration
  def change
    create_table :agendas do |t|

      t.references :cidade

      t.datetime :data
      t.string :local
      t.string :endereco
      t.string :latitude
      t.string :longitude
      t.string :passbook
      t.boolean :published
      t.text :descricao

      t.timestamps
    end
    add_index :agendas, :data
    add_index :agendas, :published
  end
end
