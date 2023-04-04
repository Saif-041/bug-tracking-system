# frozen_string_literal: true

# This class Users::RegistrationsController < Devise::RegistrationsController
class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def sign_up_params
    params.require(:user).permit(:name, :email, :user_type, :password, :password_confirmation)
  end
end
