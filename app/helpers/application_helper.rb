module ApplicationHelper
	def menu
		user = get_user
		
		if user == nil
			return {
				:login => login_index_path,
				:register => registration_index_url
			}
		end
		
		menu = {
			:logout => logout_path,
			:home => root_path,
			:chat => chat_index_path
		}
		
		if user.admin?
			menu[:admin] = admin_index_path
		end
		
		menu
	end
end
