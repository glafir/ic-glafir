class AirportPolicy < ApplicationPolicy
  def autocomplete_airport_name_rus?
    readers
  end

  def ap_dist?
    readers
  end

  def admin_ap?
    @user.admin?
  end

  def aptt?
    readers
  end

  def tablo?
    readers
  end
end
