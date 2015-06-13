class AircraftCompany < ActiveRecord::Base
include ActiveModel::Validations
  has_many :aircrafts
  attr_accessible :aircraft_company, :country_id
end
