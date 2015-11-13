class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.belongs_to :projects
      t.belongs_to :member, class: 'User'
    end
  end
end
