class Foto < ActiveRecord::Base
	belongs_to :agenda

	# shortcut validations, aka "sexy validations"
	validates :nome, :presence => true
	validates :descricao, :presence => true
	validates :flickr_album_id, :presence => true

	scope :recentes, lambda { order("fotos.created_at DESC") }
	scope :publicadas, lambda { where(:published => true) }
	scope :despublicadas, lambda { where(:published => false) }
	scope :search, lambda{|query|
		where(["descricao LIKE ?", "%#{query}%"])
	}
end
