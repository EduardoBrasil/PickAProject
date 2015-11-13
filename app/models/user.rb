class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable  

  # Give it roles
  rolify

  # Include default role to an user after its creation
  after_create :default_role 

  # Associate it with some posts
  has_many :projects, foreign_key: 'owner_id', dependent: :destroy
  has_many :project_members, foreign_key: 'member_id'

  # Add a default role to an user at its creation
  private 
	  def default_role
	    self.roles << Role.find_by_name("user")
	    self.save
	  end
end
