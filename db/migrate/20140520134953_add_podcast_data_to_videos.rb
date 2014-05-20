class AddPodcastDataToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :podcast_stream_url, :string
    add_column :videos, :podcast_duration, :string
  end
end
