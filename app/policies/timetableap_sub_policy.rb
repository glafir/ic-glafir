class TimetableapSubPolicy < ApplicationPolicy
  def flight_state?
    readers
  end

  def new?
    writers or @user.alclient?
  end

  def create?
    writers or @user.aircompany_id == @record.aircompany_id or @user.aircompany_id == @record.timetableap.aircompany_id
  end

  def update?
    writers or @user.aircompany_id == @record.aircompany_id or @user.aircompany_id == @record.timetableap.aircompany_id
  end

  def edit?
    writers or @user.aircompany_id == @record.aircompany_id or @user.aircompany_id == @record.timetableap.aircompany_id
  end
end

