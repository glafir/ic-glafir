class UserPolicy < ApplicationPolicy
  def admin
    user.admin?
  end

  def index?
    @user.admin?
  end

  def show?
    @user.admin? or @record == @user
  end

  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    return false if @user == @user
    @user.admin?
  end

end