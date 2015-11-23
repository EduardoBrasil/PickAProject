# This file includes tests for access restriction. 
# The Ability model (from CanCanCan gem) is used to define abilities of users based on their roles. 
# So, this tester basically tests the access restriction of users to any route and resource they may try to access.

require "cancan/matchers"
require 'rails_helper'

describe Ability do
	# First, load the seed.rb file in order to initialize default roles
	Rails.application.load_seed

	context "when is an admin" do
		it "should be able to manage any project" do
			user = create_user # Only valid data
			user.add_role(:admin)
			ability = Ability.new(user)
			expect(ability).to be_able_to(:manage, Project)
		end
	end

	context "when is a common user" do
		it "should be able to manage projects they are owner" do
			user = create_user # Only valid data
			ability = Ability.new(user)
			expect(ability).to be_able_to(:manage, create_project(:ong_id => ong.id))
		end

		it "should be able to create projects" do
			user = create_user # Only valid data
			ability = Ability.new(user)
			expect(ability).to be_able_to(:create, Project)
		end

		it "should be able to read projects" do
			user = create_user # Only valid data
			ability = Ability.new(user)
			expect(ability).to be_able_to(:read, create_project)
		end

		it "should not be able to edit, destroy or update any project they are not owner" do
			user = create_user # Only valid data
			ability = Ability.new(user)
			expect(ability).not_to be_able_to([:edit, :destroy, :update], create_project)
		end
	end

	context "when is guest user (not logged in)" do
		it "should be able to read projects" do
			user = User.new # guest user (not logged in)
			ability = Ability.new(user)
			expect(ability).to be_able_to(:read, create_project)
		end

		it "should not be able to create projects" do
			user = User.new # guest user (not logged in)
			ability = Ability.new(user)
			expect(ability).not_to be_able_to(:create, Project)
		end

		it "should not be able to edit, destroy or update any project" do
			ser = User.new # guest user (not logged in)
			ability = Ability.new(user)
			expect(ability).not_to be_able_to([:edit, :destroy, :update], create_project)
		end
	end

	# Methods below are used to create instances of users and projects
	private

		# Create User with default parameters, only valid fields
		def create_user(options={})
			User.create({
				email: "example@email.com",
				password: "password",
				password_confirmation: "password"
			}.merge(options))
		end

		# Create Project with default parameters, only valid fields
		def create_project(options={})
			Project.create({
				title: "Title example",
				level: "Easy",
				category: "Art",
				description: "Description example"*20,
				status: "Active",
				percentage: 50
			}.merge(options))
		end

end
