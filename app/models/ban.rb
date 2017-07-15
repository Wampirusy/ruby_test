class Ban < ActiveRecord::Base
	belongs_to :user, :class_name => 'Role', :foreign_key => 'role_id'
	
end
