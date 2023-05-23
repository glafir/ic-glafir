class StationZonePolicy < ApplicationPolicy
  def admin_station_zones?
    admin
  end
end
