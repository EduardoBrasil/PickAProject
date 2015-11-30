# Add an image path field for all projects
class AddPictureFieldAtProjectModel < ActiveRecord::Migration
	def up
    add_attachment :projects, :image_file
  end
  def down
    remove_attachment :projects, :image_file
  end
end