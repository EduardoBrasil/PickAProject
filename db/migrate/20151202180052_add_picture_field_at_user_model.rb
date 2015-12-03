# This class adds a image path field for all ongs.
class AddPictureFieldAtUserModel < ActiveRecord::Migration
	def up
		add_attachment :users, :profile_picture
	end
	def down
		remove_attachment :users, :profile_picture
	end
end
