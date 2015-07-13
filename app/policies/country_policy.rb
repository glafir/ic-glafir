class CountryPolicy < ApplicationPolicy
  def index?
    @user.admin? or @user.user?
  end

  def show?
    @user.admin? or @user.user?
  end

  def ap_show?
    @user.admin? or @user.user?
  end

  def tw_show?
    @user.admin? or @user.user?
  end

  def al_show?
    @user.admin? or @user.user?
  end

  def edit?
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
