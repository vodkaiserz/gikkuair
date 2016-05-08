class FeedbacksController < ApplicationController
	before_action :authenticate_user!

	def create
		feedback = current_user.feedbacks.create!(feedback_params)	
		redirect_to user_path(feedback.booking.user_id) 
	end

	private
		def feedback_params
			params.require(:feedback).permit(:comment, :booking_id)
		end
end
