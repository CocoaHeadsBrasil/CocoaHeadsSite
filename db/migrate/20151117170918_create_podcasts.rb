class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :title
      t.string :tags
      t.string :soundcloud_url
      t.string :itunes_url
      t.text :description
      t.datetime :created_at

      t.timestamps
    end
  end
end
