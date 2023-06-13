class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update, :destroy]

  # def show
    # @user_profile = current_user.user_profile
  # end

  # def edit
    # @user_profile = current_user.user_profile
  # end

  def update
    @user_profile = current_user.user_profile
    if @user_profile.update(user_profile_params)
      redirect_to user_profile_path, notice: "User profile updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @user_profile.destroy
    redirect_to user_profile_path, notice: "User profile deleted."
  end

  private

  def set_user_profile
    @user_profile = current_user.user_profile
  end

  def user_profile_params
    params.require(:user_profile).permit(:photo, :bio)
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
