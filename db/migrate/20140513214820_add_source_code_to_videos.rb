class AddSourceCodeToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :source, :string
  end
end
