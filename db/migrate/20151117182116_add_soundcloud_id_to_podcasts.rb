class AddSoundcloudIdToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :soundcloud_id, :string
  end
end
