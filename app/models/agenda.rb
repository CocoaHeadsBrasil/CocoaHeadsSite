class Agenda < ActiveRecord::Base

	belongs_to :cidade
	has_many :videos
	has_many :fotos

	before_validation :add_default_name

	WillPaginate.per_page = 20

	# shortcut validations, aka "sexy validations"
	validates :data, :presence => true
	validates :nome, :presence => true
	validates :endereco, :presence => true
	validates :local, :presence => true
	validates :latitude, :presence => true
	validates :longitude, :presence => true

	scope :recentes, lambda { order("agendas.data DESC, agendas.cidade_id ASC") }
	scope :por_cidade, lambda { order("agendas.cidade_id ASC, agendas.data DESC") }
	scope :ativas, lambda { where("agendas.data > ?", Time.now ) }
	scope :publicadas, lambda { where(:published => true) }
	scope :despublicadas, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["descricao LIKE ?", "%#{query}%"])
	}

	def descritivo
		"CocoaHeads " + self.cidade.cidade + " - " + self.data.strftime("%d/%m/%Y")
	end

	def descritivo_curto
		"CocoaHeads " + self.cidade.cidade
	end

	def horario
		horario = self.data.strftime("%H:%M").split(':')
		horario.last == '00' ? horario.first + 'hs' : horario.first + 'hs' + ' ' + horario.last + 'min'
	end

	def antiga?
		self.data < Time.now
	end

	# Converte para iCalendar
	def to_ics
		event = Icalendar::Event.new
		event.dtstart = self.data
		event.dtend 	= self.data + 2.hours
		event.summary = self.descritivo_curto

		event.alarm do |a|
			a.action  = "DISPLAY" # This line isn't necessary, it's the default
			a.summary = self.descritivo_curto
			a.trigger = "-P1DT0H0M0S" # 1 day before
		end

		event
	end

	private

	def add_default_name
		if self.nome.blank?
			if !self.cidade.blank?
			 	self.nome = self.descritivo
			end 
		end
	end
end
