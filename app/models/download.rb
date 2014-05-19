class Download < ActiveRecord::Base
	acts_as_list :column => "posicao"

	# shortcut validations, aka "sexy validations"
	validates :titulo, :presence => true
	validates :url, :presence => true
	validates :autor, :presence => true
	validates :posicao, :presence => true

	scope :ordenado, lambda { order("downloads.posicao ASC") }
end