class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :check_permissions, :only => [:new, :create, :cancel]
  skip_before_filter :require_no_authentication
  before_filter :configure_permitted_parameters

  protected

  def check_permissions
    authorize :user_registration, resource
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:username, :email, :time_zone, :town_id, :user_theme_id, :role)
    devise_parameter_sanitizer.for(:account_update).push(:username, :email, :time_zone, :town_id, :user_theme_id, :role)
  end

end
