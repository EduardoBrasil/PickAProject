# This class should add a new collumn in the Task table @ database
class AddPictureToTask < ActiveRecord::Migration
	def up
    add_attachment :tasks, :image_file
  end
  def down
    remove_attachment :tasks, :image_file
  end
end
