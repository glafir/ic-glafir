class AircraftWakeCategory < ActiveRecord::Base
  has_many :aircrafts
  attr_accessible :category
end
