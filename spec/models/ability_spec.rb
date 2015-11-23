# This file includes tests for access restriction. 
# The Ability model (from CanCanCan gem) is used to define abilities of users based on their roles. 
# So, this tester basically tests the access restriction of users to any route and resource they may try to access.

require "cancan/matchers"
require 'rails_helper'

describe Ability do

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
