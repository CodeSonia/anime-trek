class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    if params[:id] == 'log_out'
      log_out
    else
      @user = User.friendly.find(params[:id])
      authorize @user, policy_class: UserPolicy
    end
  end

  def edit
    @user = current_user
    authorize @user, policy_class: UserPolicy
  end

  def update
    @user = current_user
    authorize @user, policy_class: UserPolicy

    if params[:photo_update]
      if @user.update(photo: params[:photo_update])[:photo]
        redirect_to user_path(@user), notice: "Profile photo was successfully updated."
      else
        render :show
      end
    elsif @user.update(user_params)
      redirect_to user_path(@user), notice: "User was successfully updated."
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :bio, :photo)
  end


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

end
