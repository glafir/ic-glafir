class TimetableapPolicy < ApplicationPolicy
  def ttair_admin?
    @user.admin?
  end

  def flight_state?
    readers
  end

  def update_dateoffinishdate?
    writers
  end
end
