class AddMeetupToAgendas < ActiveRecord::Migration
  def change
    add_column :agendas, :meetup, :string
  end
end
