class PagesController < ApplicationController
  def home
    @profiles = Profile.paginate(:page => params[:page])
  end
  def search
    
	  @filterrific = initialize_filterrific(
	    Profile,
	    params[:filterrific],
	  select_options: {
	      category: Profile.options_for_select
      },

    ) or return
    @profiles = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
		end
	end
end


