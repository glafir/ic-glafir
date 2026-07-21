class RwEltrainsRoute < ApplicationRecord
include ActiveModel::Validations
belongs_to :station
has_many :rw_eltrains_timetables
belongs_to :rw_route
paginates_per 100
end
