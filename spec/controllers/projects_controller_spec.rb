require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

	context "http response" do
		before(:each) do
			@enterprise_project = create_project_with_task # Valid project
      @enterprise_project.save
		end

		describe 'GET index' do
			it "should work" do
				get :index
				expect(response).to have_http_status(:success)
			end
		end

		describe 'GET show' do
			it "should work" do
				get :show, id: @enterprise_project.id
				expect(response).to have_http_status(:success)
			end
		end

		describe 'GET edit' do
			it "should work" do
				get :edit, id: @enterprise_project.id
				expect(response).to have_http_status(:success)
			end
		end

		describe 'GET new' do
			it "should work" do
				get :new
				expect(response).to have_http_status(:success)
			end
		end

		describe 'POST create' do
			it "should work" do
				post :create, project: some_params
				expect(response).to have_http_status(:redirect)
			end
		end

		describe 'PUT update' do
			it "should work" do
				put :update, id: @enterprise_project.id, project: { 
					title: "a" * Project::TITLE_MIN_LENGTH } # Valid title
				expect(response).to have_http_status(:redirect)
			end
		end

		describe 'DELETE destroy' do
			it "should work" do
				delete :destroy, id: @enterprise_project.id
				expect(response).to have_http_status(:redirect)
			end
		end

	end

	context 'creating with valid params' do
		it "saves project" do
			expect{(
				post :create, project: some_params
				)}.to change(Project, :count).by(1)
		end

		it "redirects to the project's page" do
				post :create, project: some_params
				expect(response).to redirect_to (projects_path + "/1")
		end
	end

	context 'try to create with invalid attributes' do
		it "does not save project" do
			expect{(
				post :create, project: some_params(title: "a" * (Project::TITLE_MIN_LENGTH - 1))
				)}.not_to change(Project, :count)
		end
	end

	context 'template rendering' do
		it "renders the template index" do
			get :index
			expect(response).to render_template("index")
		end

		it "renders the template new" do
			get :new
			expect(response).to render_template("new")
		end
	end

	context "route" do
		it "routes get index" do
			expect(get: "projects").to route_to(
				controller: "projects",
				action: "index")
		end

		it "routes get new" do
			expect(get: "projects/new").to route_to(
				controller: "projects",
				action: "new")
		end

		it "routes get show" do
			expect(get: "projects/1").to route_to(
				controller: "projects", 
				action: "show", 
				id: "1")
		end
		
		it "routes get edit" do 
			expect(get: "projects/1/edit").to route_to(
				controller: "projects",
				action: "edit",
				id: "1")
		end

		it "routes post create" do
			expect(post: "projects").to route_to(
				controller: "projects",
				action: "create")
		end

		it "routes put update" do
			expect(put: "projects/1").to route_to(
				controller: "projects",
				action: "update",
				id: "1")
		end

		it "routes delete destroy" do
			expect(delete: "projects/1").to route_to(
				controller: "projects",
				action: "destroy",
				id: "1")
		end
	end
	
	private
    # Method to create some valid and writable Projects params
    # This must be invalid because there is no registered task
    def create_project(options = {})
      project = Project.create(some_params(options))
      return project
    end

    # Valid params for the project
    def some_params(options = {})
      return ({
        title: "a"*(Project::TITLE_MIN_LENGTH),
        description: "a"*(Project::DESCRIPTION_MIN_LENGTH),
        percentage: 0,
        level: Project::PERMITTED_LEVELS.first, # Returns the string "Easy"
        category: Project::PERMITTED_CATEGORIES.first, # Returns the string "Art"
        status: Project::PERMITTED_STATUS.first # Returns the string "Active"
      }.merge(options))
    end
end
