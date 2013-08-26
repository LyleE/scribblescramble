module UsersHelper
	def rank user, users
		pos = 1 + @users.find_index {|u| u.rating == user.rating }
		pos = "="+pos.to_s if @users.select {|u| u.rating == user.rating}.length > 1
		pos
	end
end
