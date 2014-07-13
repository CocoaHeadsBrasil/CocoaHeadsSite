class Agenda < ActiveRecord::Base

	belongs_to :cidade
	has_many :videos
	has_many :fotos

	before_validation :add_default_name

	WillPaginate.per_page = 20

	# shortcut validations, aka "sexy validations"
	validates :cidade_id, :presence => true
	validates :data, :presence => true
	validates :nome, :presence => true
	validates :endereco, :presence => true
	validates :local, :presence => true
	validates :latitude, :presence => true
	validates :longitude, :presence => true

	scope :recentes, lambda { order("agendas.data DESC, agendas.cidade_id ASC") }
	scope :por_data, lambda { order("agendas.data ASC, agendas.cidade_id ASC") }
	scope :por_cidade, lambda { order("agendas.cidade_id ASC, agendas.data DESC") }
	scope :ativas, lambda { where("agendas.data > ?", Time.now ) }
	scope :passadas, lambda { where("agendas.data < ?", Time.now ) }
	scope :publicadas, lambda { where(:published => true) }
	scope :despublicadas, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["descricao LIKE ?", "%#{query}%"])
	}

	def evento_com_detalhes
		self.nome + " - CocoaHeads " + self.cidade.cidade + " - " + self.data_formatada
	end

	def descritivo
		"CocoaHeads " + self.cidade.cidade + " - " + self.data_formatada
	end

	def descritivo_curto
		"CocoaHeads " + self.cidade.cidade
	end

	def horario
		horario = self.data.strftime("%H:%M").split(':')
		horario.last == '00' ? horario.first + 'hs' : horario.first + 'hs' + ' ' + horario.last + 'min'
	end

	def data_formatada
		self.data.strftime("%d/%m/%Y")
	end

	def antiga?
		self.data < Time.now
	end

	def dias_restantes
		dias_restantes = (Time.zone.now -  self.data).abs.to_i / 1.day

		if dias_restantes < 1
			"acontece hoje!" if !self.antiga?
		else
			plural = dias_restantes == 1 ? "dia" : "dias"
			"em #{dias_restantes} #{plural}" if !self.antiga?
		end
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
