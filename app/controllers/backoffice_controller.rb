class BackofficeController < ApplicationController
	before_action :authenticate_admin!
	layout "backoffice"  

	def pundit_user
		current_admin # Current_user to Pudint 		
	end
end