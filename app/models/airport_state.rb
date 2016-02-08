class AirportState < ActiveRecord::Base
include ActiveModel::Validations
  paginates_per 25
  has_many :airport
end
