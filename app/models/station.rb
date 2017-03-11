class Station < ActiveRecord::Base
paginates_per 100
belongs_to :station_type
belongs_to :station_zone
end
