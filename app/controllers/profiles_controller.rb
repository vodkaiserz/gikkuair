class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  def index
    @profile = current_user.profile
  end

  def show
    @photos = @profile.photos
    @user = User.find(params[:id])
  end

  def new
    @profile = current_user.build_profile
    @profile.videos.build
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
      render :new
    end
  end


  def edit
    @profile.videos.build
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
       
      @photos = @profile.photos 
        redirect_to edit_profile_path(@profile), notice: "Profile updated!!"
      end
    else
      flash[:alert] = "Profile could not be updated!"
      render :edit
    end
  end
  def destroy
    @profile.destroy

    redirect_to profiles_path, notice: "Profile deleted!!"
end
  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:category, :member, :profile_name, :bio, :location, :is_english, :is_indonesia, :is_travel, :is_wedding, :is_corporate, :is_private, :is_birthday, :is_school, :is_cafe, :profilepic, :coverphoto, videos_attributes: [:id, :link, :_destroy])
    end
end  

