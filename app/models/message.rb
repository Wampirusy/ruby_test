class Message < ActiveRecord::Base
	belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
	belongs_to :reciver, :class_name => 'User', :foreign_key => 'reciver_id'
	
end
