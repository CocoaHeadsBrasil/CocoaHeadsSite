include Gravtastic

class Cidade < ActiveRecord::Base

	has_many :agendas
	belongs_to :estado

	before_validation :add_default_social_networks
	after_create :send_hubot_create_message
	after_destroy :send_hubot_delete_message

  	has_gravatar :organizador_email,
  				 :secure => true,
  				 :default => "https://s3.amazonaws.com/content.cocoaheads.com.br/images/anonymous.png",
  				 :size => 120,
  				 :rating => 'R'

  	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	# shortcut validations, aka "sexy validations"
	validates :cidade, :presence => true
	validates :email, :presence => true,
	            :length => { :maximum => 100 },
	            :format => EMAIL_REGEX
	validates :organizador, :presence => true
	validates :organizador_email, :presence => true,
	            :length => { :maximum => 100 },
	            :format => EMAIL_REGEX

	scope :ordenados, lambda { order("cidades.cidade ASC") }
	scope :por_estado, lambda { joins(:estado).order("estados.nome, cidades.cidade") }
	scope :publicados, lambda { where(:published => true) }
	scope :despublicados, lambda { where(:published => false) }

	def nome_do_capitulo
		"CocoaHeads " + self.cidade
	end

	def has_website?
		self.website != Cocoaheads::Application::COCOAHEADS_SOCIAL_WEB
	end

	def has_github?
		self.github != Cocoaheads::Application::COCOAHEADS_SOCIAL_GITHUB
	end

	def has_twitter?
		self.twitter != Cocoaheads::Application::COCOAHEADS_SOCIAL_TWITTER
	end

	def has_facebook?
		self.facebook != Cocoaheads::Application::COCOAHEADS_SOCIAL_FACEBOOK
	end

	private

	def add_default_social_networks
		if website.blank?
			self.website = Cocoaheads::Application::COCOAHEADS_SOCIAL_WEB
		end

		if github.blank?
			self.github = Cocoaheads::Application::COCOAHEADS_SOCIAL_GITHUB
		end

		if twitter.blank?
			self.twitter = Cocoaheads::Application::COCOAHEADS_SOCIAL_TWITTER
		end

		if facebook.blank?
			self.facebook = Cocoaheads::Application::COCOAHEADS_SOCIAL_FACEBOOK
		end
	end

	def send_hubot_create_message
		numero_cidades = Cidade.all.count
		Hubot.send_message "Um novo chapter acaba de ser criado no website do CocoaHeadsBR: #{self.cidade}, leader: #{self.organizador}. Agora somos #{numero_cidades} chapters registrados."
	end

	def send_hubot_delete_message
		numero_cidades = Cidade.all.count
		Hubot.send_message "Um chapter acaba de ser excluído do website do CocoaHeadsBR: #{self.cidade}. :cry:. Agora somos #{numero_cidades} chapters registrados.", {:mood => :bad}
	end
end
