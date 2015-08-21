class AircompanyPolicy < ApplicationPolicy
  def admin_al?
    @user.admin?
  end

  def autocomplete_aircompany_airline_name_rus?
    readers
  end

  def update?
    writers or @user.aircompany_id == @record.id
  end

  def edit?
    writers or @user.aircompany_id == @record.id
  end
end
