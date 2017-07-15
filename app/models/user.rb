class User < ActiveRecord::Base
	belongs_to :role, :class_name => 'Role', :foreign_key => 'role_id'
	  
	validates :login, uniqueness: true
	
	
	def banned?
		Ban.where({:user_id => id}).any?
	end
end
