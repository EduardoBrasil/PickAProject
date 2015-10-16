class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :author
      t.string :title
      t.string :project_type
      t.string :description
      t.string :status
      t.integer :percentage

      t.timestamps null: false
    end
  end
end
