class AdminController < ApplicationController
	
	def index
		user = User.find(session[:user_id])
		
		user.admin?
	end
end
