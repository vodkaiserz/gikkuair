module ApplicationHelper
	def avatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		if user.image
			user.image
		else
			return "https://gravatar.com/avatar/#{gravatar_id}.jpg"
		end
	end
	
end
