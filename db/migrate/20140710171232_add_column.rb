class AddColumn < ActiveRecord::Migration
  def change
  	add_column :videos, :podcast_counter, :integer, :default => 0
  end
end