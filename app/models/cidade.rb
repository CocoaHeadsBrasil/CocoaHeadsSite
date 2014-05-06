class Cidade < ActiveRecord::Base

	has_many :agendas

	include Gravtastic
  	gravtastic :organizador_email

	# # shortcut validations, aka "sexy validations"
	# validates :cidade, :presence => true
	# validates :endereco, :presence => true
	# validates :local, :presence => true
	# validates :latitude, :presence => true
	# validates :longitude, :presence => true

	# scope :por_data, lambda { order("agendas.data DESC") }
	# scope :por_cidade, lambda { order("agendas.cidade_id ASC, agendas.data DESC") }
	# scope :published, lambda { where(:published => true) }
	# scope :unpublished, lambda { where(:published => false) }
	# scope :search, lambda{|query|
	# 	where(["descricao LIKE ?", "%#{query}%"])
	# }

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
end
