class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@profiles = @user.profiles

		bookings = @user.bookings
		bookings_with_host = []
		bookings.each do |booking|
			if current_user && current_user.profiles.include?(booking.profile)
				bookings_with_host << booking
			end
		end

		@booking = bookings_with_host.first
		@feedback = Feedback.new
		@guest_feedbacks = @user.feedbacks_for_me
	end
end