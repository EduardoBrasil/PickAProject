# This class adds a image path field for all ongs.
class AddPictureFieldAtUserModel < ActiveRecord::Migration
  def up
    add_attachment :ongs, :profile_picture
  end
  def down
    remove_attachment :ongs, :profile_picture
  end
end
