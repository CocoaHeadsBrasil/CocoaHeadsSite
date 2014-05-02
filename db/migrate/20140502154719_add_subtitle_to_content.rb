class AddSubtitleToContent < ActiveRecord::Migration
  def change
    add_column :contents, :subtitle, :string
  end
end
