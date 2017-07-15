class User < ActiveRecord::Base
	belongs_to :role, :class_name => 'Role', :foreign_key => 'role_id'
	  
	validates :name, presence: true
	validates :login, uniqueness: true, presence: true
	validates :password, presence: true
	
	def banned?
		Ban.where({:user_id => id}).any?
	end
	
	def admin?
		role.name == 'admin'
	end
end
