class PagesController < ApplicationController
  def home
    @profiles = Profile.all
	  
  end
  def DJ
	  @profiles = Profile.where(category: "DJ")
	  render :template => "home"
  end
end
