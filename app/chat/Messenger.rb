class Messenger
	attr_reader :user
	
	def initialize(user)
		@user = user
	end
		
	def hi
		from_server("hi, #{@user.name}")
	end
		
	def bye
		from_server("bye, #{@user.name}")
	end
	
	def from_server(text)
		from(:server, text)
	end
	
	def from_user(text)
		from(@user.name, text)
	end
		
	def from(author, text) 
		{
			message: {
				author: author,
				text: text
			}
		}.to_json	
	end
		
	def user_list
		{
			users: User.all.to_a.map do |user|
				status = case true
				when user.banned?
					:banned
				when $user_sockets[user.name] != nil
					:online
				else
					:offline
				end
				{
					name: user.name,
					status: status
				}
			end			
		}.to_json	
	end
	
	def parse(data)
		JSON.parse(data)
	end
end
