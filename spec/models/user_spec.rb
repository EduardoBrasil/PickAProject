require 'rails_helper'

RSpec.describe User, type: :model do
	# First, load the seed.rb file in order to initialize default roles
	Rails.application.load_seed

	context "when providing valid data" do
		before :each do
			@user = create_user
		end

		# Testing the valid user generator
		it "should be valid to the create_user test method" do
			expect(@user).to be_valid
		end

		# Testing increasing database
		it "should increase the database" do
			another_user = @user.dup
			another_user.email = "another@email.com"
			another_user.username = "another username"
			expect{
				another_user.save
			}.to change(User, :count).by(1)
		end

		# Testing associations
		it "should be owner of a new project" do
			expect{
				@user.own_projects << create_project
			}.to change(@user.own_projects, :count).by(1)
		end
		it "should be member of a new project" do
			expect{
				project = create_project
				task = create_task
				project.tasks << task
				@user.tasks << task
			}.to change(@user.projects, :count).by(1)
		end
		it "should have a new task" do
			expect{
				@user.tasks << create_task
			}.to change(@user.tasks, :count).by(1)
		end
	end

	# Methods below are used to create instances of models
	private
		# Create User with default parameters, only valid fields
		def create_user(options={})
			User.create({
				username: "user example",
				email: "example@email.com",
				password: "password",
				password_confirmation: "password"
			}.merge(options))
		end

		# Create Project with default parameters, only valid fields
		def create_project(options={})
			Project.create({
				title: "title example",
				level: "Easy",
				category: "Art",
				description: "description example"*20,
				status: "Active",
				percentage: 50
			}.merge(options))
		end

		# Create Task with default parameters, only valid fields
		def create_task(options={})
			Task.create({
				title: "title example",
				difficult: 1,
				description: "description example"*20
			}.merge(options))
		end
end
