class LoginController < ApplicationController
  def create
		user = User.where(
			:login => params[:login],
			:password => params[:password]
		).first
		
		if user == nil
			flash[:error] = 'i don\'t know you'
				
			redirect_to login_index_path
		else
			session[:user_id], session[:name] = user.id, user.name
			
			if user.banned?
				flash[:error] = 'you is bunny!'
				
				redirect_to login_index_path
			elsif user.admin?
				redirect_to admin_index_path
			else
				redirect_to chat_index_path
			end
		end
  end
	
	def logout
		session[:user_id] = session[:name] = nil
		
		redirect_to root_path
	end
end
