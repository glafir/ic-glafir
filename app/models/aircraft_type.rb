class AircraftType < ActiveRecord::Base
include ActiveModel::Validations
  has_many :aircrafts
#  attr_accessible :atype
end
