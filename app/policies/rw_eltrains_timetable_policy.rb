class RwEltrainsTimetablePolicy < ApplicationPolicy
  def admin_rw_eltrains_timetables?
    admin
  end
end
