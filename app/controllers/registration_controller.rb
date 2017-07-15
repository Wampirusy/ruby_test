class RegistrationController < ApplicationController
  def index
		@user = User.new
  end
	
	def create
		@user = User.new(user_params)
		@user.role = Role.where({:name => 'admin'}).first

		if @user.save
			redirect_to :root
		else
			flash[:error] = 'zzzzz'
		end
	end
	
	private
	def user_params
		params.require(:user).permit(:name, :login, :password)
	end
end
