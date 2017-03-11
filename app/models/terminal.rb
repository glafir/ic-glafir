class Terminal < ActiveRecord::Base
include ActiveModel::Validations
paginates_per 50
belongs_to :airport
end
