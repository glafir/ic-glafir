class GeneralPolicy < ApplicationPolicy
  def add_sub_tt?
    writers
  end
end
