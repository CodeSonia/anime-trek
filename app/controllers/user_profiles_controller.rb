class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update, :destroy]

  def show
    @user_profile = UserProfile.find(params[:id])
  end

  def edit
    @user_profile = UserProfile.find(params[:id])
  end

  def update
    if @user_profile.update(user_profile_params)
      redirect_to @user_profile, notice: "User profile updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @user_profile.destroy
    redirect_to user_profiles_url, notice: "User profile deleted."
  end

end


# i wrote these actions below but then i saw that they are not necessary. leaving them as comments just in case. - issa

# def new
#   @user_profile = UserProfile.new
# end

# def index
#   @user_profiles = UserProfile.all
# end

# def create
# @user_profile = UserProfile.new(params[:user_profile])
# if @user_profile.save
#   redirect_to @user_profile
# else
#   render "new"
# end
# end
# end
