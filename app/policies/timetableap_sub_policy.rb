class TimetableapSubPolicy < ApplicationPolicy
  def flight_state?
    readers
  end
end

