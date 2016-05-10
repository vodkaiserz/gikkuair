class PagesController < ApplicationController
  def home
    @profiles = Profile.all
  end

  def search
    @profiles = Profile.filter(params.slice(:category, :location, :starts_with))

    @arrProfiles = @profiles.to_a

    

    end

  end
end
