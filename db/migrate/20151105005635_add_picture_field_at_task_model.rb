# This class should add a new collumn in the Task table @ database
class AddPictureFieldAtTaskModel < ActiveRecord::Migration
	def up
    add_attachment :projects, :image_file
  end
  def down
    remove_attachment :projects, :image_file
  end
end
