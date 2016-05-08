class BookingsController < ApplicationController
	before_action :authenticate_user!, except: [:notify]

	
	def preload
		profile = Profile.find(params[:profile_id])
		today = Date.today
		bookings = profile.bookings.where("start_datetime >= ? OR end_datetime >= ?", today, today)

		render json: bookings
	end

	def preview
		start_datetime = Date.parse(params[:start_datetime])
		end_datetime = Date.parse(params[:end_datetime])

		output = {
			conflict: is_conflict(start_datetime, end_datetime)
		}

		render json: output
	end

	def create
		profile = Profile.find(params[:profile_id])
		if current_user.profiles.include?(profile)
			flash[:alert] = "You cannot book your own profile."
			redirect_to profile_path(profile)
		else
			@booking = current_user.bookings.create!(booking_params)
			redirect_to profile_path(@booking.profile), notice: "Your booking has been created!"
		end
	end

	protect_from_forgery except: [:notify]
	  def notify
	    params.permit!
	    status = params[:payment_status]

	    booking = Booking.find(params[:item_number])

	    if status = "Completed"
	      booking.update_attributes status: true
	    else
	      booking.destroy
	    end

	    render nothing: true
	  end
	protect_from_forgery except: [:your_pastevents]
	def your_pastevents
		@pastevents = current_user.bookings.where("status = ?", true)
	end

	def your_bookings
		@profiles = current_user.profiles
	end

	private
		def is_conflict(start_datetime, end_datetime)
			profile = Profile.find(params[:profile_id])
			check = profile.bookings.where("? < start_datetime AND end_datetime < ?", start_datetime, end_datetime)
			if check.size > 0
				return true
			else
				return false
			end
		end

		def booking_params
			params.require(:booking).permit(:start_datetime, :end_datetime, :performance_fee, :total, :profile_id)
		end
end
