# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  protected

  def sign_up_params
    params.require(:user).permit(:name, :email, :user_type, :password, :password_confirmation)
  end

end
