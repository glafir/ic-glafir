class TownPolicy < ApplicationPolicy
  def admin_tw?
    @user.admin?
  end

  def tw_dist?
    @user.admin? or @user.user?
  end
end
