class AirportDistance < ApplicationRecord
include ActiveModel::Validations
paginates_per 25

  belongs_to :airport_start, class_name: "Airport", foreign_key: "airport_start_id"
    scope :ordered_by_airport_start_city_rus, -> { joins(:airport_start).order('airports.city_rus') }
  belongs_to :airport_finish, class_name: "Airport", foreign_key: "airport_finish_id"
    scope :ordered_by_airport_finish_city_rus, -> { joins(:airport_finish).order('airports.city_rus') }


  validates  :airport_finish_id, presence: true, numericality: { only_integer: true }
  validates  :airport_start_id, presence: true, numericality: { only_integer: true },
                    length: { maximum: 999999 },
                  uniqueness: { scope: :airport_finish_id, message: "This Flight is exist!" }

end
