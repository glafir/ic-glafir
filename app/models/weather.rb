class Weather < ApplicationRecord
include ActiveModel::Validations
paginates_per 25
has_many :weather_states
belongs_to :airport, foreign_key: "place_id"
end
