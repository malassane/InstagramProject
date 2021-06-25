class ProfilesController < ApplicationController

  skip_before_action :login_required, only: [:new, :create]
  def show
       @profile = Profile.find(params[:id])
  end

  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def create
      @user = current_user.profile.build(user_params)

      @profile = Profile.new(profile_params)
      if @profile.save

      redirect_to profile_path(@profile.id)
      else
        render :new
      end
  end

  def edit

  end

  def update
    if @profile.update(profile_params)
      redirect_to profiles_path, notice: "I edited my profile"
    else
    render :edit
    end
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def destroy
    @profile.destroy
    redirect_to profiles_path, notice:"I deleted the blog!"
  end



  private
    def profile_params
      params.require(:profile).permit(:picture, :picture_cache)

    end

end
