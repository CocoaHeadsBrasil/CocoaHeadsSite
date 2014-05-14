class AdminUser < ActiveRecord::Base

	# To configure a different table name
	# self.table_name = "admin_users"

	# The line below is a very helpful method that
	# makes lots of things behind the scenes.
	# 1. creates an attribute named :password
	# 2. automatically hash it if we pass a unencrypted pw
	# 3. validates it
	# 4. Authenticate the user :)
	has_secure_password

  	has_gravatar :email,
  				 :secure => true,
  				 :default => "https://s3.amazonaws.com/content.cocoaheads.com.br/images/anonymous.png",
  				 :size => 120,
  				 :rating => 'R'

	# has_and_belongs_to_many :pages
	# has_many :section_edits
	# has_many :sections, :through => :section_edits

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	FORBIDDEN_USERNAMES = ['littlebopeep', 'humptydumpty', 'marymary', 'admin', 'root', 'administrator']
	# validates_presence_of :first_name
	# validates_length_of :first_name, :maximum => 25
	# validates_presence_of :last_name
	# validates_length_of :last_name, :maximum => 50
	# validates_presence_of :username
	# validates_length_of :username, :within => 8..25
	# validates_uniqueness_of :username
	# validates_presence_of :email
	# validates_length_of :email, :maximum => 100
	# validates_format_of :email, :with => EMAIL_REGEX
	# validates_confirmation_of :email

	# shortcut validations, aka "sexy validations"
	validates :first_name, :presence => true,
	                 :length => { :maximum => 25 }
	validates :last_name, :presence => true,
	                :length => { :maximum => 50 }
	validates :username, :length => { :within => 3..25 },
	               :uniqueness => true
	validates :email, :presence => true,
	            :length => { :maximum => 100 },
	            :format => EMAIL_REGEX,
	            :confirmation => true

	validate :username_is_allowed
	# validate :no_new_users_on_saturday, :on => :create

	# could be done calling admin_users. but theres no ambiguous join happening. Simple SQL. 
	# scope :sorted, lambda { order("admin_users.last_name ASC, admin_users.first_name ASC") }
	scope :sorted, lambda { order("admin_users.last_name ASC, admin_users.first_name ASC") }

	def username_is_allowed
		if FORBIDDEN_USERNAMES.include?(username)
			errors.add(:username, "has been restricted from use.")
		end
	end

	# Erros not related to a specific attribute
	# can be added to erros[:base]
	def no_new_users_on_saturday
		if Time.now.wday == 6
			errors[:base] << "No new users on saturday."
		end
	end

	def name
		first_name + " " + last_name
	end
end
