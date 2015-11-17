class Foto < ActiveRecord::Base

	belongs_to :agenda

	after_create :send_hubot_create_message
	after_destroy :send_hubot_delete_message

	# shortcut validations, aka "sexy validations"
	validates :agenda_id, :presence => true
	validates :descricao, :presence => true
	validates :flickr_album_id, :presence => true

	scope :recentes, lambda { joins(:agenda).order("agendas.data DESC, fotos.created_at DESC") }
	scope :publicadas, lambda { where(:published => true) }
	scope :despublicadas, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["descricao LIKE ?", "%#{query}%"])
	}

	def random_thumb(onlyLandscape=true, retina=false)

		pickedPhoto = nil
		photoSize = retina ? "Large 1024" : "Thumbnail"

		begin
		    photosRequest = Flickr.sets.get_photos(self.flickr_album_id, {sizes:["Thumbnail", "Large 1024"]})
		rescue
		ensure
			if photosRequest && photosRequest.count > 0
				loopLimit = 0
				until loopLimit == 100	# only accept 100 tries
					photo = photosRequest.sample

					if retina
						photo.largest!
					else
						photo.thumbnail!
					end

				   	if onlyLandscape
				   		if photo.width > photo.height
				   			pickedPhoto = photo
				   			break
				   		end
				   	else
				   		pickedPhoto = photo
				   		break
				   	end

				   	photosRequest.delete(photo)	# delete so no repeated loops happens

				   	loopLimit += 1
				end 
			end
		end

        pickedPhoto
	end

	def random_thumb_url(onlyLandscape=true, retina=false)
		photo = self.random_thumb(onlyLandscape, retina)
		photo.source_url if photo
	end

	private

	def send_hubot_create_message
		Hubot.send_message "Novo album de fotos criado no website do CocoaHeadsBR: #{self.agenda.evento_com_detalhes} - http://www.cocoaheads.com.br/fotos/detalhes/#{self.id}"
	end

	def send_hubot_delete_message
		Hubot.send_message "Album de fotos excluído do website do CocoaHeadsBR: #{self.agenda.evento_com_detalhes}", {:mood => :bad}
	end

end
