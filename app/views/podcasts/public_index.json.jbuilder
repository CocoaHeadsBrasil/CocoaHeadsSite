json.array!(@podcasts) do |podcast|
  json.extract! podcast, :id, :title, :tags, :soundcloud_url, :itunes_url, :description, :created_at
  json.url podcast_url(podcast, format: :json)
end
