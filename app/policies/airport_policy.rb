class AirportPolicy < ApplicationPolicy
  def autocomplete_airport_name_rus?
    true
  end

  def ap_dist?
    @user.admin? or @user.user?
  end

  def admin_ap?
    @user.admin?
  end

  def aptt?
    @user.admin? or @user.user?
  end

  def tablo?
    @user.admin? or @user.user?
  end

  def ap_dist?
    @user.admin? or @user.user?
  end
end
