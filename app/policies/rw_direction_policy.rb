class RwDirectionPolicy < ApplicationPolicy
  def admin_rw_directions?
    admin
  end
end
