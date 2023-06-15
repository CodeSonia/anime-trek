class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def show
    @user = current_user
    authorize @user, policy_class: UserPolicy
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

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      nil
    end
  end


  def set_user
    @user = current_user || UserProfile.new(user: current_user)
    @user = current_user
  end

  def user_params
    params.require(:user_profile).permit(:photo, :bio, :points)
  end
end
