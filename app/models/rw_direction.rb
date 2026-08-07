class RwDirection < ApplicationRecord
include ActiveModel::Validations
belongs_to :station
belongs_to :direction_station, class_name: "Station", foreign_key: "direction_station_id"

paginates_per 100
end
