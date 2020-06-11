class WeatherState < ApplicationRecord
include ActiveModel::Validations
paginates_per 25
belongs_to :weather
end
