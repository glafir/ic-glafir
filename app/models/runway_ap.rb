class RunwayAp < ActiveRecord::Base
  belongs_to :airport
  attr_accessible :airport_id, :runway_name,  :runway_data, :runway_elevation, :runway_length
end
