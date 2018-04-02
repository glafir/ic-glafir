class AircraftWakeCategory < ActiveRecord::Base
include ActiveModel::Validations
  has_many :aircrafts
#  attr_accessible :category
end
