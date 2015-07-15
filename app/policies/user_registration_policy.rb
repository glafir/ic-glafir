class UserRegistrationPolicy < ApplicationPolicy
  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def edit?
    @user.admin? or @user == @user
  end

  def update?
    @user.admin? or @user == @user
  end

  def sign_up?
    @user.admin?
  end

  def destroy?
    return false if @user == @user
    @user.admin?
  end

end
