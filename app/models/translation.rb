class Translation < ActiveRecord::Base
include ActiveModel::Validations
paginates_per 25
end
