class PagesController < ApplicationController
  def home
    @profiles = Profile.all
  end

  def search
    @profiles = Profile.filter(params.slice(:category, :location, :starts_with))

    @arrProfiles = @profiles.to_a

    if (params[:start_datetime] && params[:end_datetime] && params[:start_datetime].empty? && !params[:end_datetime].empty?)
      start_datetime = Date.parse(params[:start_datetime])
      end_datetime = Date.parse(params[:end_datetime])

      @profiles.each do |profile|

        not_available = profile.bookings.where(
          "(? <= start_datetime AND start_datetime <= ?
            OR (? <= end_datetime AND end_datetime <= ?)
            OR (? <= start_datetime < ? AND ? < end_datetime)",
            start_datetime, end_datetime,
            start_datetime, end_datetime,
            start_datetime, end_datetime
        ).limit(1)

        if not_available.length > 0
          @arrProfiles.delete(profile)
        end
      end

    end

  end
end
