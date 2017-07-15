class NameController < ApplicationController
  def index
		if params['name'] != nil
			@name = params['name']
			redirect_to :hello
		end
  end
	
	def hello
		if params[:name]
			session[:name] = params[:name]
		end
		
		@name = session[:name]
	end
end
