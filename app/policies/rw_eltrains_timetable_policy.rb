class RwEltrainsTimetablePolicy < ApplicationPolicy
  def admin_rw_eltrains_timetables?
    admin
  end

  def add_eltrain?
    admin
  end

  def edit_eltrain?
    admin
  end

  def create_bulk?
    admin
  end

  def update_bulk?
    admin
  end

  def destroy_bulk?
    admin
  end
end
