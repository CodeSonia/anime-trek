class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update, :destroy]


  def show

    @user_profile = current_user.user_profile
    authorize @user_profile, policy_class: UserProfilePolicy
  end

  #def edit
  #  @user_profile = current_user.user_profile
  #end

  #def update

  #  @user_profile = current_user.user_profile
  #  if @user_profile.update(user_profile_params)
  #    redirect_to user_user_profile_path(current_user), #notice: "User profile updated successfully."
   # else
   #   render :edit
   # end
  #end

  #def destroy

   # @user_profile = current_user.user_profile
  #  @user_profile.destroy
  #  redirect_to user_user_profile_path(current_user), notice: #"User profile deleted."
  #end

  private

  def set_user_profile
    @user_profile = current_user.user_profile || UserProfile.new(user: current_user)
    @user = current_user
  end

  def user_profile_params
    params.require(:user_profile).permit(:photo, :bio)
  end
end
