class RwDirection < ApplicationRecord
include ActiveModel::Validations
belongs_to :station
belongs_to :direction_station, class_name: "Station", foreign_key: "direction_station_id"
scope :order_by_direction_station, -> { joins(:station).merge(Station.order(name_rus: :asc)) }
paginates_per 100

  def direction_station_name_rus
    direction_station.name_rus
  end

end
