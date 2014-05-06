class Estado < ActiveRecord::Base

	has_many :cidades

	scope :ordenados, lambda { order("estados.nome ASC") }
	scope :search, lambda{|query|
		where(["nome LIKE ?", "%#{query}%"])
	}

end
