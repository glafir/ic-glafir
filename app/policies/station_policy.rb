class StationPolicy < ApplicationPolicy
  def admin_stations?
    admin
  end

  def autocomplete_station_name_rus?
    readers
  end

end
