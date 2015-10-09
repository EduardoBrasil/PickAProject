class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :type_project
      t.string :description
      t.string :status
      t.integer :percentage

      t.timestamps null: false
    end
  end
end
