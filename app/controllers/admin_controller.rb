class AdminController < ApplicationController
  include Netzke::Railz::ControllerExtensions
  before_filter :authorize, only: [:index, :ext, :direct, :dispatcher]

#  def admin?
#    authorize [:index, :ext, :direct, :dispatcher], :admin?
#  end

  skip_before_action :verify_authenticity_token, only: [:ext, :direct, :dispatcher]

private
  def authorize
    authorize :admin
  end
end
