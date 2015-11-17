namespace :podcasts do
  desc "Update podcast with soundcloud"
  task updateWithSoundcloud: :environment do
  	Podcast.updateWithSoundcloud
  end
end