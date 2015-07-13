class UserRegistrationPolicy < ApplicationPolicy
  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def sign_up?
    @user.admin?
  end

  def destroy?
    return false if @user == @user
    @user.admin?
  end

end
