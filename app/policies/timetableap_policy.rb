class TimetableapPolicy < ApplicationPolicy
  def ttair_admin?
    admin
  end

  def search_tt?
    readers
  end

  def flight_state?
    readers
  end

  def update_dateoffinishdate?
    writers or @user.aircompany_id == @record.aircompany_id
  end

  def new?
    writers or @user.alclient?
  end

  def create?
    writers or @user.aircompany_id == @record.aircompany_id
  end

  def update?
    writers or @user.aircompany_id == @record.aircompany_id
  end

  def edit?
    writers or @user.aircompany_id == @record.aircompany_id
  end
end
