class UserThemePolicy < ApplicationPolicy
  def edit?
    admin
  end

  def update?
    admin
  end

  def new?
    admin
  end

  def create?
    admin
  end

  def destroy?
    admin
  end
end
