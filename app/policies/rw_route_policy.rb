class RwRoutePolicy < ApplicationPolicy
  def admin_rw_routes?
    admin
  end
end
