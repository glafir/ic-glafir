# encoding: UTF-8
class RwTypestation < ActiveRecord::Base
has_many :rw_stations
  attr_accessible :typestation_name
end

