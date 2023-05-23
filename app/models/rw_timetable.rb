class RwTimetable < ApplicationRecord
include ActiveModel::Validations
paginates_per 25
end
