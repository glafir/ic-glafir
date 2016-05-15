class StationPolicy < ApplicationPolicy
  def admin_stations?
    admin
  end
end
