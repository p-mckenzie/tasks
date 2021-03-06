# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :permit_user_parameters, if: :devise_controller?

  protected

  def permit_user_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:user_group_assignments, keys: %i[title password email id])
  end
end
