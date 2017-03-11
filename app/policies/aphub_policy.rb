class AphubPolicy < ApplicationPolicy
  def admin_aphub?
    admin
  end
end
