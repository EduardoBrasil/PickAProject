class ProjectMember < ActiveRecord::Base
  # Associate it with some posts
  belongs_to :projects
  belongs_to :member, class: 'User'
end
