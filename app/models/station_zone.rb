class StationZone < ActiveRecord::Base
has_many :stations
validates  :zone, presence: true,
           length: { is: 5 },
           uniqueness: true,
           :format => {:with => /\A[0-9]{5}\z/i}
end
