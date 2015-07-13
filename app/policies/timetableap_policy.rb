class TimetableapPolicy < ApplicationPolicy
  def ttair_admin?
    @user.admin?
  end

  def flight_state?
    @user.admin? or @user.user?
  end

  def update_dateoffinishdate?
    @user.admin?
  end
end
