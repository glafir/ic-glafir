class RwEltrainsRoutePolicy < ApplicationPolicy
  def admin_rw_eltrains_routes?
    admin
  end
end
