class AddingFotosReferenceToAgendas < ActiveRecord::Migration
  def change
    add_column :agendas, :foto_id, :integer
    add_index :agendas, :foto_id
  end
end
