class PagesController < ApplicationController
	# Use this controller as a resource of CanCan and Rolify
  load_and_authorize_resource

	def home
	end
end
