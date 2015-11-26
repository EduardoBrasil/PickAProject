require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:each) do
    @project = create_project
  end

  context "when providing correct data" do
    it "should be an instance of Task" do
      # Custom helper, see support folder
      task = create_task
      expect(task).to be_an_instance_of(Task)
    end

    it "should be valid when belongs to a project" do
      task = create_task
      @project.tasks << task
      # Get the inserted task
      task_of_project = @project.tasks.last
      expect(task_of_project).to be_valid
    end

    it "should increase the database when is valid" do
      task = create_task
      expect{
        @project.tasks << task
        @project.save
      }.to change(@project.tasks, :count).by(1)
    end

    it "should have the project foreign key" do
      task = create_task
      @project.tasks << task
      task_of_the_project = @project.tasks.last
      expect(task_of_the_project.project_id).to eq(@project.id)
    end
  end

  context "when providing invalid data" do
    it "should be invalid when not belongs to a project" do
      task = create_task
      expect(task).not_to be_valid
    end

    it "should not increase the database when is invalid" do
      task = create_task({
        title: "a"*(Task::TITLE_MIN_LENGTH - 1)
      })
      expect{
        @project.tasks << task
        @project.save
      }.to change(@project.tasks, :count).by(0)
    end

    context "when testing wrong title values" do
      it "should not be valid without a title" do
        task = create_project_with_task().tasks.last
        task.title = nil
        expect(task).not_to be_valid
      end

      it "should not be valid with too short title" do
        task = create_project_with_task(task_options: {
          title: "a"*(Task::TITLE_MIN_LENGTH - 1)
        }).tasks.last
        expect(task).not_to be_valid
      end

      it "should not be valid with too long title" do
        task = create_project_with_task(task_options: {
          title: "a"*(Task::TITLE_MAX_LENGTH + 1)
        }).tasks.last
        expect(task).not_to be_valid
      end
    end

    context "when testing wrong description values" do
      it "should not be valid without a description" do
        task = create_project_with_task().tasks.last
        task.description = nil
        expect(task).not_to be_valid
      end

      it "should not be valid with too short description" do
        task = create_project_with_task(task_options: {
          description: "a"*(Task::DESCRIPTION_MIN_LENGTH - 1)
        }).tasks.last
        expect(task).not_to be_valid
      end

      it "should not be valid with too long description" do
        task = create_project_with_task(task_options: {
          description: "a"*(Task::DESCRIPTION_MAX_LENGTH + 1)
        }).tasks.last
        expect(task).not_to be_valid
      end
    end

    context "when testing wrong difficult values" do
      it "should not be valid without a difficult" do
        task = create_project_with_task().tasks.last
        task.difficult = nil
        expect(task).not_to be_valid
      end

      it "should not be valid with nun numerical values" do
        task = create_project_with_task(task_options: {
          difficult: "a"
        }).tasks.last
        expect(task).not_to be_valid
      end

      it "should not be valid with invalid fibonacci values" do
        [4, 10, 22].each do |each_test_value|
          task = create_project_with_task(task_options: {
            difficult: each_test_value
          }).tasks.last
          expect(task).not_to be_valid
        end
      end
    end
  end
end
