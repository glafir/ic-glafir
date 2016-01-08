class RunwayApPolicy < ApplicationPolicy

  def runway_calendar?
    readers
  end
end
