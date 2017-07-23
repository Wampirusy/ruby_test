class ChatController < ApplicationController
  include Tubesock::Hijack
	include ChatHelper
	
	def index
		user = get_user
		if user == nil or user.banned?
			redirect_to login_index_path
		else
			cookies[:socket_url] = chat_sock_url.gsub(/https?:/, 'ws:')
		end
	end
	
	def sock
		if user = get_user
			messenger = Messenger.new(user)
			sender = Sender.new(messenger)
			
			hijack do |sock|
				sock.onopen do
					$user_sockets[user.name] = sock
					sender.hi_all
				end
				
				sock.onclose do
					$user_sockets.delete(user.name)
					sender.bye_all
				end

				sock.onmessage do |data|
					message = messenger.parse(data)
					
					if message['text'] && message['text'].size > 0
						if message['recepients'] && message['recepients'].any?
							recepients = message['recepients']
							recepients.push(user.name)
							sender.say_to(recepients, message['text'])
						else
							sender.say_to_all(message['text'])
						end
						
					end
				end
			end
		else
			redirect_to login_index_path
		end
  end
	
	def no_sock
		hijack do |sock|
			sock.onmessage do |data|
				message = JSON.parse(data)
				p message
				
				if message.session_id != nil
					session = Session.where(:session_id => message.session_id).first
					login = JSON.parse(session.data)['value']['login']
					if login != nil
						$users[login] = sock
						$sessions_active[login] = session_id
						answer = {:auth => 'yes'}
						sock.send_data(answer.to_json)
						send_active_user_list
					else
						answer = {:auth => 'no'}
						sock.send_data(answer.to_json)						
					end
				end
								
				if message.login != nil
					reciver = message.login
					sender = getloginbysock(sock)
					if sender == nil
						answer = {:auth => 'no'}
						sock.send_data(answer.to_json)						
					end
					if reciver == nil
						savemessagetodb(reciver, sender, message)
					else
						answer = {:auth => 'yes', :login => sender, :message => message}
						sock.send_data(answer.to_json)	
					end
				end
					
				if message.broadcast != nil

					$redis.lpush('broadcast', login:huyogin)
				end
				
			end
		end
	end
	
	
end
