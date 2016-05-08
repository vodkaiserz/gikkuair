class PhotosController < ApplicationController
	def destroy
		@photo = Photo.find(params[:id])
		profile = @photo.profile

		@photo.destroy
		@photos = Photo.where(profile_id: profile.id)

		respond_to :js
	end
end
