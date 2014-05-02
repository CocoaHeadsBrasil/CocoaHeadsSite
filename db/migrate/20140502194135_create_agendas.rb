class CreateAgendas < ActiveRecord::Migration
  def change
    create_table :agendas do |t|
      t.string :horario
      t.string :local
      t.string :maps
      t.string :passbook
      t.boolean :published
      t.text :descricao

      t.timestamps
    end
  end
end
