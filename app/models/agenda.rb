class Agenda < ActiveRecord::Base

	belongs_to :cidade

	# shortcut validations, aka "sexy validations"
	validates :data, :presence => true
	validates :endereco, :presence => true
	validates :local, :presence => true
	validates :latitude, :presence => true
	validates :longitude, :presence => true

	scope :por_data, lambda { order("agendas.data DESC") }
	scope :por_cidade, lambda { order("agendas.cidade_id ASC, agendas.data DESC") }
	scope :published, lambda { where(:published => true) }
	scope :unpublished, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["descricao LIKE ?", "%#{query}%"])
	}

end
