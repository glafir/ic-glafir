class AirportPolicy < ApplicationPolicy
  def autocomplete_airport_city_rus?
    readers
  end

  def ap_maps?
    readers
  end
  
  def search_ap_circle?
    readers
  end

  def apload?
    readers
  end

  def ap_dist?
    readers
  end

  def admin_ap?
    admin
  end

  def aptt?
    readers
  end

  def tablo?
    readers
  end
end
