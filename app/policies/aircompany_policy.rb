class AircompanyPolicy < ApplicationPolicy
  def admin_al?
    @user.admin?
  end
end
