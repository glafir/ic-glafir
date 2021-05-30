class Terminal < ActiveRecord::Base
include ActiveModel::Validations
paginates_per 300
belongs_to :airport
end
