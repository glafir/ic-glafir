class AircraftType < ActiveRecord::Base
  has_many :aircrafts
  attr_accessible :atype
end
