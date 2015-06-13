class RwTypestation < ActiveRecord::Base
include ActiveModel::Validations
has_many :rw_stations
  attr_accessible :typestation_name
end

