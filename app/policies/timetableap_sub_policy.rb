class TimetableapSubPolicy < ApplicationPolicy
  def flight_state?
    @user.admin? or @user.user?
  end
end

