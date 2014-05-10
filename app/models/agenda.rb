class Agenda < ActiveRecord::Base

	belongs_to :cidade
	has_many :videos
	has_many :fotos

	# shortcut validations, aka "sexy validations"
	validates :data, :presence => true
	validates :endereco, :presence => true
	validates :local, :presence => true
	validates :latitude, :presence => true
	validates :longitude, :presence => true

	scope :recentes, lambda { order("agendas.data DESC") }
	scope :por_cidade, lambda { order("agendas.cidade_id ASC, agendas.data DESC") }
	scope :published, lambda { where(:published => true) }
	scope :unpublished, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["descricao LIKE ?", "%#{query}%"])
	}

	def descritivo
		"CocoaHeads " + self.cidade.cidade + " - " + self.data.strftime("%d/%m/%Y")
	end

	def descritivo_curto
		"CocoaHeads " + self.cidade.cidade
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

end
