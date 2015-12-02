class User < ActiveRecord::Base
	# Devise is a flexible authentication solution for Rails based on Warden
	# Include its default modules
	devise :database_authenticatable, :registerable,
				 :rememberable, :trackable, :validatable  

	# Give it roles
	rolify

	# Include default role to an user after their registration
	after_create :default_role

	# Associate users to projects that they own
	has_many :own_projects, foreign_key: 'owner_id', class_name: "Project"
	
	# Associate users to projects that they contribute (make tasks)
	has_many :tasks
	has_many :projects, through: :tasks

	# Attach a profile picture to an user
	# Paperclip gem sintax for upload image files.
	has_attached_file :profile_picture, :styles => {}, :default_url => "/images/:style/missing_profile_picture.png"
	validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/

	# Add a default role to an user at its creation
	private 
		def default_role
			self.roles << Role.find_by_name("user")
			self.save
		end
end
