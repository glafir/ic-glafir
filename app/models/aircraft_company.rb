class AircraftCompany < ActiveRecord::Base
  attr_accessible :aircraft_company, :country_id
  cattr_reader :per_page
  @@per_page = 10
end
