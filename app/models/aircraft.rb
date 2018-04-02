class Aircraft < ActiveRecord::Base
include ActiveModel::Validations
  belongs_to :aircraft_company 
  belongs_to :aircraft_type
  belongs_to :aircraft_wake_category
  has_many :timetableaps
#  attr_accessible :aircraft_iata_code, :aircraft_icao_code, :aircraft_maxspeed, :aircraft_model, :aircraft_seats, :aircraft_type_id, :aircraft_wake_category_id, :aircraft_webinfo, :aircraft_company_id
end
