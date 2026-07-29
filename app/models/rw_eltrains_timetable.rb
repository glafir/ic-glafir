class RwEltrainsTimetable < ApplicationRecord
include ActiveModel::Validations
belongs_to :rw_eltrains_route
belongs_to :station
validates  :direction, presence: true, numericality: {only_integer: true}, length: { is: 1 }
validates  :station_id, presence: true, numericality: {only_integer: true}
validates  :rw_eltrains_route_id, presence: true, numericality: {only_integer: true}
validates  :eltrains_number, presence: true, numericality: {only_integer: true}, length: { in: 3..4 },
                             uniqueness: { scope: :station_id, message: "This Train is exist om this station!" }
paginates_per 100
end
