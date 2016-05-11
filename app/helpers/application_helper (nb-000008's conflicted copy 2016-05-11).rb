module ApplicationHelper
	def avatar_url(user)
		if profile.profilepic
			return profile.profilepic
		else
			gravatar_id = Digest::MD5::hexdigest(user.email).downcase
			return "https://gravatar.com/avatar/#{gravatar_id}.jpg"
		end
	end
	def proposal
		Proposal.new
	end
end
