class RwEltrainsRoute < ApplicationRecord
include ActiveModel::Validations
belongs_to :station
has_many :rw_eltrains_timetables
paginates_per 100
end
