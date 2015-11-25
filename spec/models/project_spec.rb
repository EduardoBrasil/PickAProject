require 'rails_helper'

RSpec.describe Project, type: :model do
  context "when providing valid data" do
    before :each do
      @project = create_project_with_task
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

    it "should have a new task" do
      expect{
        @project.tasks << create_task
      }.to change(@project.tasks, :count).by(1)
    end
  end

  context "when providing invalid data" do
    it "should not increase the database" do
      project = create_project_with_task(project_options: {
        title: "a"*(Project::TITLE_MAX_LENGTH + 1)
      })
      expect{
        project.save
      }.to change(Project, :count).by(0)
    end

    it "should not be valid without a task" do
      project = create_project
      expect(project).not_to be_valid
    end

    context "when testing wrong titles" do
      it "should no be valid without a title" do
        project = create_project_with_task
        # Manually adding of nil param, there is no way
        # to do it with hash's merge method
        project.title = nil
        expect(project).not_to be_valid
      end

      it "should not be valid with too short title" do
        project = create_project_with_task(project_options: {
          title: "a"*(Project::TITLE_MIN_LENGTH - 1)
        })
        expect(project).not_to be_valid
      end

      it "should not be valid with too long title" do
        project = create_project_with_task(project_options: {
          title: "a"*(Project::TITLE_MAX_LENGTH + 1)
        })
        expect(project).not_to be_valid
      end
    end

    context "when testing wrong descriptions" do
      it "should no be valid without a description" do
        project = create_project_with_task
        # Manually adding of nil param, there is no way
        # to do it with hash's merge method
        project.description = nil
        expect(project).not_to be_valid
      end

      it "should not be valid with too short description" do
        project = create_project_with_task(project_options: {
          description: "a"*(Project::DESCRIPTION_MIN_LENGTH - 1)
        })
        expect(project).not_to be_valid
      end

      it "should not be valid with too long description" do
        project = create_project_with_task(project_options: {
          title: "a"*(Project::DESCRIPTION_MAX_LENGTH + 1)
        })
        expect(project).not_to be_valid
      end
    end

    context "when testing wrong percentage values" do
      it "should not be valid without percentage value" do
        project = create_project_with_task
        # Manually adding of nil param, there is no way
        # to do it with hash's merge method
        project.percentage = nil
        expect(project).not_to be_valid
      end

      it "should not be valid with non numerical characters" do
        project = create_project_with_task(project_options: {
          percentage: "a"
        })
      end

      it "should not be valid with stupid percentage values" do
        project = create_project_with_task(project_options: {
          percentage: 101
        })
        expect(project).not_to be_valid
      end

      it "should not be valid with stupid percentage values" do
        project = create_project_with_task(project_options: {
          percentage: -1
        })
        expect(project).not_to be_valid
      end
    end

    context "when testing wrong level values" do
      it "should not be valid without level value" do
        project = create_project_with_task
        project.level = nil
        expect(project).not_to be_valid
      end

      it "should not be valid with values that are not specified in the model" do
        project = create_project_with_task(project_options: {
          level: "stupid test string"
        })
        expect(project).not_to be_valid
      end
    end

    context "when testing with wrong categories" do
      it "should not be valid without category" do
        project = create_project_with_task
        project.category = nil
        expect(project).not_to be_valid
      end

      it "should not be valid with categories that are not specified in the model" do
        project = create_project_with_task(project_options: {
          category: "stupid test string"
        })
        expect(project).not_to be_valid
      end
    end

    context "when testing with wrong status" do
      it "should not be valid without status" do
        project = create_project_with_task
        project.status = nil
        expect(project).not_to be_valid
      end

      it "should not be valid with status that are not specified in the model" do
        project = create_project_with_task(project_options: {
          status: "stupid test string"
        })
        expect(project).not_to be_valid
      end
    end
  end
end
