include Gravtastic

class Cidade < ActiveRecord::Base

	has_many :agendas
	belongs_to :estado

	before_validation :add_default_social_networks

  	has_gravatar :organizador_email,
  				 :secure => true,
  				 :default => "https://s3.amazonaws.com/content.cocoaheads.com.br/images/anonymous.png",
  				 :size => 120,
  				 :rating => 'R'

  	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	# shortcut validations, aka "sexy validations"
	validates :cidade, :presence => true
	validates :organizador, :presence => true
	validates :organizador_email, :presence => true,
	            :length => { :maximum => 100 },
	            :format => EMAIL_REGEX

	scope :ordenados, lambda { order("cidades.cidade ASC") }
	scope :por_estado, lambda { order("estados.nome, cidades.cidade") }
	scope :publicados, lambda { where(:visible => true) }
	scope :despublicados, lambda { where(:visible => false) }

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


  # create_table "cidades", force: true do |t|
  #   t.string   "cidade"
  #   t.string   "estado"
  #   t.string   "organizador"
  #   t.string   "organizador_email"
  #   t.string   "website"
  #   t.string   "github"
  #   t.string   "twitter"
  #   t.string   "facebook"
  #   t.boolean  "published"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end
  # 
end
