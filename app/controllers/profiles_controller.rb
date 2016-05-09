class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @profile = current_user.profile
  end

  def show
    @photos = @profile.photos
    @user = User.find(params[:id])
    @booked = Booking.where("profile_id = ? AND user_id = ?", @profile.id, current_user.id).present? if current_user
    @reviews = @profile.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      if params[:images]
        params[:images].each do |image|
          @profile.photos.create!(image: image)
        end
      end

      @photos = @profile.photos
      redirect_to edit_profile_path(@profile), notice: "Profile created!"
    else
      flash[:alert] = "Profile could not be created!"
      render :new
    end
  end

  def edit
    if current_user.id == @profile.user.id
      @photos = @profile.photos
    else
      redirect_to root_path, notice: "You don't have permission."
    end
  end

  def update
    if @profile.update(profile_params)
      if @profile.save
        if params[:images]
          params[:images].each do |image|
            @profile.photos.create(image: image)
          end
        end
      
      # @photos = @profile.photos // testing to see if I don't need this?
        redirect_to edit_profile_path(@profile), notice: "Profile updated!!"
      else
        flash[:alert] = "Profile could not be updated!"
        render :edit
      end
    end
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:category, :member, :profile_name, :bio, :location, :is_english, :is_indonesia, :is_travel, :is_wedding, :is_corporate, :is_private, :is_birthday, :is_school, :is_cafe, :performance_fee, :profilepic)
    end
end  

