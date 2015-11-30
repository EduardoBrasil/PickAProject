class PagesController < ApplicationController
	# Bypass authorization check for pages controller.
	skip_authorization_check

	def home
	end
end
