class ApiPolicy < ApplicationPolicy
  def getAirports?
    readers
  end

  def getCountries?
    readers
  end
end
