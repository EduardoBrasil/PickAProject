class Project < ActiveRecord::Base
  # Use project as a rolify resource
  resourcify

  # Each project has an owner
  belongs_to :owner, class_name: 'User'
  has_many :project_members

  # Each project has some tasks
  # Each task is a small thing that should be done in the project.
  has_many :tasks, dependent: :destroy
  validates_associated :tasks
  # Enable nested_form gem to work well
  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true

  # Attach image to a project
  has_attached_file :image_file, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  # Check if the image file's name is valid
  validates_attachment_content_type :image_file, :content_type => /\Aimage\/.*\Z/

  # Impossible to create a task without a title
  validates(:title, presence:true)
  TITLE_MAX_LENGTH = 60 # Characters
  TITLE_MIN_LENGTH = 3  # Characters
  validates(:title, length: { in: TITLE_MIN_LENGTH...TITLE_MAX_LENGTH })

  # Impossible to create a task without a description
  validates(:description, presence: true)
  DESCRIPTION_MAX_LENGTH = 10000 # Characters
  DESCRIPTION_MIN_LENGTH = 200 # Characters
  validates(:description, length: { in: DESCRIPTION_MIN_LENGTH...DESCRIPTION_MAX_LENGTH })

  # Impossible to create a project without difficult setting
  validates(:percentage, presence: true)
  # Accept only numbers for difficult
  validates(:percentage, numericality: { only_integer: true })
  # Percentage values should not be out of range (0%,100%)
  validates_inclusion_of(:percentage, in: 0...100)

  # Impossible to create a project without a level
  validates(:level, presence: true)
  # Only 3 types of level are permitted
  PERMITTED_LEVELS = %w(Easy Medium Hard)
  validates(:level, inclusion: PERMITTED_LEVELS)

  # Impossible to create a project without a category
  validates(:category, presence: true)
  CATEGORY_MAX_LENGTH = 30 # Characters
  CATEGORY_MIN_LENGTH = 3 # Characters
  validates(:category, length: { in: CATEGORY_MIN_LENGTH...CATEGORY_MAX_LENGTH})
  PERMITTED_CATEGORIES = %w(Art Tecnology Musical Education Toy)
  validates(:category, inclusion: PERMITTED_CATEGORIES)

  # Impossible to create a project without a status
  validates(:status, presence: true)
  # Only 3 types of level are permitted
  PERMITTED_STATUS = %w(Active Planning Stopped Finished)
  validates(:status, inclusion: PERMITTED_STATUS)

end
