class Sender
	def initialize(messenger)
		@messenger = messenger
	end
	
	def hi_all
		send($user_sockets, @messenger.hi)
		send($user_sockets, @messenger.user_list)
	end
	
	def bye_all
		send($user_sockets, @messenger.bye)
		send($user_sockets, @messenger.user_list)
	end
	
	def say_to(recepients, text)
		recepients.uniq.each do | name |
			if $user_sockets[name]
				send($user_sockets[name], @messenger.from_user(text))
			else
				user = User.where({:name => name}).first
				
				if (user == nil || user.banned?)
					send($user_sockets[@messenger.user.name], @messenger.from_server("i don't know #{name}"))
				else
					Message.new({
							:sender => @messenger.user,
							:reciver => User.where({:name => name}).first,
							:text => text
						}).save();
				end
			end
		end
	end
	
	def say_to_all(text)
		send($user_sockets, @messenger.from_user(text))
	end
	
	protected
	def send(socks, message)
		if socks.is_a?(Tubesock)
			socks.send_data message
		elsif socks.is_a?(Hash)
			socks.to_a.each { |user, sock| sock.send_data message }
		end				
	end
end
