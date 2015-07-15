class CountryPolicy < ApplicationPolicy
  def index?
    readers
  end

  def show?
    readers
  end

  def ap_show?
    readers
  end

  def tw_show?
    readers
  end

  def al_show?
    readers
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
