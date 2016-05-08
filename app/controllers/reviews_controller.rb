class ReviewsController < ApplicationController

	def create
		@review = current_user.reviews.create!(review_params)
		redirect_to profile_path(@review.profile)
	end
	
	def destroy
		review = Review.find(params[:id])
		profile = review.profile
		review.destroy

		redirect_to profile_path(profile)
	end

	private
		def review_params
			params.require(:review).permit(:comment, :star, :profile_id)
		end
end
