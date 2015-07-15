class AdminPolicy < ApplicationPolicy
#class AdminPolicy < Struct.new(:user, :admin)
#  def initialize(user, record)
#    raise Pundit::NotAuthorizedError, "must be logged in" unless user
#    @user = user
#    @record = record
#  end

  def index?
    @user.admin?
#    authorize @user, :admin
#    true
  end

  def ext?
    @user.admin?
#    authorize @user, :admin
#    true
  end

  def direct?
    @user.admin?
#    authorize @user, :admin
#    true
  end

  def dispatcher?
    @user.admin?
#    authorize @user, :admin
#    true
  end
end
