class Video < ActiveRecord::Base
	belongs_to :palestrante
	belongs_to :agenda

	after_create :send_hubot_create_message

	WillPaginate.per_page = 20

	YOUTUBE_REGEX = /\A([a-zA-Z0-9\-_]+)\Z/i

	# shortcut validations, aka "sexy validations"
	validates :titulo, :presence => true
	validates :tags, :presence => true
	validates :youtube, :presence => true,
			  :format => YOUTUBE_REGEX,
			  :uniqueness => true

	validate :podcast_stream_valido
	validate :podcast_duracao_valido

	scope :mais_novos, lambda { order("videos.created_at DESC") }
	scope :mais_antigos, lambda { order("videos.created_at ASC") }
	scope :por_agenda, lambda { order("agendas.data DESC, videos.titulo") }
	scope :com_podcast, lambda { where("videos.podcast_stream_url != ''") }
	scope :sem_podcast, lambda { where("videos.podcast_stream_url == ''") }
	scope :publicados, lambda { where(:published => true) }
	scope :despublicados, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["descricao LIKE ? OR titulo LIKE ? OR tags LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%"])
	}

	def youtube_embed_url
		"http://www.youtube.com/embed/#{self.youtube}?rel=0&amp;vq=hd1080"
	end

	def podcast?
		!self.podcast_duration.nil?
	end

	def duracao_podcast_sem_pontuacao
		self.podcast_duration.delete ':'
	end

	private

	# Erros not related to a specific attribute
	# can be added to erros[:base]
	def podcast_stream_valido
		if !self.podcast_duration.empty? && self.podcast_stream_url.empty?
			errors[:base] << "A url do stream do podcast deve ser informada."
		end
	end

	def podcast_duracao_valido
		if !self.podcast_stream_url.empty? && self.podcast_duration.empty?
			errors[:base] << "A duração do podcast deve ser informada."
		end
	end

	def send_hubot_create_message
		Hubot.send_message "Novo vídeo criado no website do CocoaHeadsBR: #{self.titulo} por #{self.palestrante.nome}"
	end
end
