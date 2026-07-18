class RwEltrainsTimetable < ApplicationRecord
include ActiveModel::Validations
belongs_to :rw_eltrains_route
has_one :station, through: :rw_eltrains_route
paginates_per 100
end
