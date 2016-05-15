class Station < ActiveRecord::Base
paginates_per 1000
belongs_to :station_type
belongs_to :station_zone
end
