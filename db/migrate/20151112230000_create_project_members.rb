class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.belongs_to :projects, index: true
      t.belongs_to :member, class: 'User', index: true
    end
  end
end
