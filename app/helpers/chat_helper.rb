module ChatHelper
	
	
	
	def get_user
		if session[:user_id] != nil
			user = User.find(session[:user_id])
		end
	end
	
#	def message (author, text)
#		{
#			auth: session[:user_id],
#			users: get_users,
#			#			users: $user_sockets.keys,
#			message: {
#				author: author,
#				text: text
#			}
#		}.to_json
#	end
#	
#	def send_message(sock, author, text)
#		p [author, text]
#		sock.send_data message(author, text)
#	end
#	
#	def get_users
#		#		p 'zzzzzzzzzzzzzzzz',User.all.to_a
#		User.all.to_a.map do |user|
#			status = case true
#			when user.banned?
#				:banned
#			when $user_sockets[user.name]
#				:online
#			else
#				:offline
#			end
#			#			13
#			{
#				name: user.name,
#				status: status
#			}
#		end
#	end
end
