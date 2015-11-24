class AddTotalToAgendas < ActiveRecord::Migration
  def change
    add_column :agendas, :total, :integer, :default => 0
  end
end
