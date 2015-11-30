class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.belongs_to :owner, index: true

      #[TODO] this field should be removed and substituted by an asssociation
      t.string :author

      t.string :title # The project name.

      t.string :level # It's about the difficult of the project.
                      # Should be easy, medium or hard.

      t.string :category # Best way to find projects by category.
                         # Users can create new categories.

      t.text :description # A simple introduction to the project.

      t.string :status # The status should be "active", "finished or, "stopped".

      t.integer :percentage # Reflects the progress of the project.

      t.timestamps null: false
    end
  end
end
