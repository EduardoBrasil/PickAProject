require 'rails_helper'

RSpec.describe Project, type: :model do
  context "when providing valid data" do
    before :each do
      @project = create_project
    end

    # Testing the valid project generator
    it "should be valid to the create_project test method" do
      expect(@project).to be_valid
    end

    # Testing increasing database
    it "should increase the database" do
      another_project = @project.dup
      expect{
        another_project.save
        
      }.to change(Project, :count).by(1)
    end
  end

  context "when providing invalid data" do
    it "should not increase the database" do
      project = create_project({
        title: "a"*(Project::TITLE_MAX_LENGTH + 1)
      })
      expect{
        project.save
      }.to change(Project, :count).by(0)
    end
  end

  private
  # Method to create some valid and writable Projects objects
  def create_project(options = {})
    project = Project.create({
      title: "a"*(Project::TITLE_MIN_LENGTH),
      description: "a"*(Project::DESCRIPTION_MIN_LENGTH),
      percentage: 0,
      level: Project::PERMITTED_LEVELS.first, # Returns the string "Easy"
      category: Project::PERMITTED_CATEGORIES.first, # Returns the string "Art"
      status: Project::PERMITTED_STATUS.first # Returns the string "Active"
    }.merge(options))

    return project
  end

  # Create a valid task to validate the project
  def get_task_params(options = {})
    task_params = {
      title: "a"*(Task::TITLE_MIN_LENGTH),
      difficult: Task::PERMITTED_FIBONACCI_VALUES.first,
      description: "a"*(Task::DESCRIPTION_MIN_LENGTH)
    }.merge(options)

    return task_params
  end

end
