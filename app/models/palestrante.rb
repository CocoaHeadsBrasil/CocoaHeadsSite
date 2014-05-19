include Gravtastic

class Palestrante < ActiveRecord::Base
	
	has_many :videos

  	has_gravatar :email,
  				 :secure => true,
  				 :default => "https://s3.amazonaws.com/content.cocoaheads.com.br/images/anonymous.png",
  				 :size => 400,
  				 :rating => 'R'

  	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	# shortcut validations, aka "sexy validations"
	validates :nome, :presence => true
	validates :email, :presence => true,
	            :length => { :maximum => 100 },
	            :format => EMAIL_REGEX

	scope :ordenados, lambda { order("palestrantes.nome") }
	scope :publicados, lambda { where(:published => true) }
	scope :despublicados, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["nome LIKE ?", "%#{query}%"])
	}

	def mini_curriculo?
		!mini_curriculo.blank?
	end

end
