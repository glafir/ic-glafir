class Station < ActiveRecord::Base
paginates_per 100
belongs_to :station_type
belongs_to :station_zone
has_many :rw_routes, dependent: :destroy, class_name: "RwRoute", inverse_of: :rw_start_route, foreign_key: "start_route"
end
