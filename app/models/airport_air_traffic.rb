class AirportAirTraffic < ActiveRecord::Base
include ActiveModel::Validations
paginates_per 25
has_many :airports
end
