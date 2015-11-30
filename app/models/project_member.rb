class ProjectMember < ActiveRecord::Base
  # Associate it with some posts
  belongs_to :projects
  belongs_to :member, class_name: 'User'
end
