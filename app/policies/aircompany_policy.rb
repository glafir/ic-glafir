class AircompanyPolicy < ApplicationPolicy
  def admin_al?
    @user.admin?
  end

  def autocomplete_aircompany_airline_name_rus?
    readers
  end
end
