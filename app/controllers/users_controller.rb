class UsersController < ApplicationController
  #before_action :authenticate_user!


  def show
    @user = User.find(params[:id])
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

end