class LoginController < ApplicationController
  def create
		user = User.where(
			:login => params[:login],
			:password => params[:password]
		).first
		
		if user != nil
			p user
			session[:login] = user.login
			session[:admin] = user.role.name == 'admin'
			if user.banned?
				session[:bunny] = true
				flash[:error] = 'banned'
				
				redirect_to login_index_path
			end
			
			redirect_to chat_index_path
		else
			flash[:error] = 'hz'
				
			redirect_to login_index_path
		end
  end
end
