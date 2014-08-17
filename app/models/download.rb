class Download < ActiveRecord::Base
	acts_as_list :column => "posicao"

	after_create :send_hubot_create_message

	# shortcut validations, aka "sexy validations"
	validates :titulo, :presence => true
	validates :url, :presence => true
	validates :autor, :presence => true
	validates :posicao, :presence => true

	scope :ordenado, lambda { order("downloads.posicao ASC") }

	private

	def send_hubot_create_message
		Hubot.send_message "Novo arquivos disponibilizado no backend do website do CocoaHeadsBR: #{self.titulo} por #{self.autor}."
	end
end