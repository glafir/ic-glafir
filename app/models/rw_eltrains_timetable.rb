class RwEltrainsTimetable < ApplicationRecord
include ActiveModel::Validations
belongs_to :rw_eltrains_route
belongs_to :station
paginates_per 100
end
