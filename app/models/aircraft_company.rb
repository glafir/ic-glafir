class AircraftCompany < ActiveRecord::Base
  has_many :aircrafts
  attr_accessible :aircraft_company, :country_id
end
