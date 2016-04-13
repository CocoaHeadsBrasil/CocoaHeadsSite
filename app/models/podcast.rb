class Podcast < ActiveRecord::Base
    
    after_create :send_hubot_create_message

	def self.updateWithSoundcloud
	
    require 'net/http'

    url = URI.parse('http://api.soundcloud.com/users/95096755/tracks?client_id=9f4fc83993488ca781ad264b2f2a2e41')
    result = Net::HTTP.get(url)
    podcasts = JSON.parse result
    podcasts.reverse!
    podcasts.each{|podcast|
      if (!Podcast.where(soundcloud_id: podcast["id"].to_s).first)
        Podcast.create(title: podcast["title"], 
        description: podcast["description"], 
        soundcloud_id: podcast["id"], 
        tags: podcast["tag_list"], 
        soundcloud_url: podcast["permalink_url"],
        created_at: podcast["created_at"])
      end
    }
	end

    def send_hubot_create_message
        Hubot.send_message "Novo podcast do CocoaHeads Brasil publicado: #{self.title} - http://www.cocoaheads.com.br/podcasts/detalhes/#{self.id}"
        
        Hubot.send_message "Novo podcast do CocoaHeads Brasil publicado: #{self.title} - http://www.cocoaheads.com.br/podcasts/detalhes/#{self.id}", {:channel => "#podcast"}
        
    end
end
