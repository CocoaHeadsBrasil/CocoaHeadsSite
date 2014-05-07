class Video < ActiveRecord::Base
	belongs_to :palestrante
	belongs_to :agenda

	YOUTUBE_REGEX = /\A([a-zA-Z0-9\-_]+)\Z/i

	# shortcut validations, aka "sexy validations"
	validates :titulo, :presence => true
	validates :youtube, :presence => true,
			  :format => YOUTUBE_REGEX,
			  :uniqueness => true

	scope :mais_novos, lambda { order("videos.created_at DESC") }
	scope :mais_antigos, lambda { order("videos.created_at ASC") }
	scope :por_agenda, lambda { order("agendas.data DESC, videos.titulo") }
	scope :publicados, lambda { where(:published => true) }
	scope :despublicados, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["descricao LIKE ? OR titulo LIKE ?", "%#{query}%", "%#{query}%"])
	}

	def youtube_embed_url
		"http://www.youtube.com/embed/#{self.youtube}?rel=0&amp;vq=hd1080"
	end

	def youtube_embed_code
		"<iframe width=\"853\" height=\"480\" src=\"" + self.youtube_embed_url + "\" frameborder=\"0\" allowfullscreen></iframe>"
	end
end
