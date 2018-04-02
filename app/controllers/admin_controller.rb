class AdminController < ApplicationController
  include Netzke::Railz::ControllerExtensions

  before_action :check_permissions, :only => [:index, :ext, :direct, :dispatcher]
  skip_before_action :authenticate_user!, unless: :devise_controller?
  protect_from_forgery :except => [:index, :ext, :direct, :dispatcher]
  skip_after_action :verify_authorized

  protected

  def check_permissions
    authorize :admin
  end
end
