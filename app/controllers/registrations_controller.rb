class RegistrationsController < Devise::RegistrationsController
  def update
    super do |resource|
      if resource.errors.empty?
        flash[:notice] = "Profile was successfully updated."
      end
    end
  end

  private

  def registration_params
    params.require(:user).permit(:username, :email, :bio, :password, :password_confirmation)
  end
end
