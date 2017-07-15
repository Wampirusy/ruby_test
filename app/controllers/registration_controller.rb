class RegistrationController < ApplicationController
  def index
		@user = User.new
  end
	
	def create
		@user = User.new(user_params)
		@user.role = Role.where({:name => 'user'}).first
		
		p @user,@user.save,@user.errors
		
		if @user.save
			redirect_to :root
		else
			flash[:error] = @user.errors
			
			redirect_to registration_index_path
		end
	end
	
	private
	def user_params
		params.require(:user).permit(:name, :login, :password)
	end
end
