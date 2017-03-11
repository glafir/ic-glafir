class Airport < ActiveRecord::Base
include ActiveModel::Validations
acts_as_mappable :default_units => :kms,
                   :default_formula => :flat,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
  paginates_per 10
  has_many :terminals
  has_many :aircompanies, dependent: :destroy
  belongs_to :town
  belongs_to :airport_state
  belongs_to :airport_air_traffic
  has_many :runway_aps, dependent: :destroy
  has_many :timetableaps_in, dependent: :destroy, class_name: "Timetableap", inverse_of: :airport_finish, foreign_key: "way_end"
  has_many :timetableaps_out, dependent: :destroy, class_name: "Timetableap", inverse_of: :airport_start, foreign_key: "way_start"
  belongs_to :country
  has_many :aphubs
  attr_accessible :Dist_to_town, :Terminals, :TerminalsColl, :city_eng, :city_rus, :email, :fax, :gmt_offset, :iata_code, :icao_code, :iso_code, :latitude, :longitude, :name_eng, :name_rus, :phone, :runnway_coll, :runway_elevation, :runway_length, :website, :town_id, :aircompanies_count, :country_id, :time_zone, :airport_state_id, :weather_state
  attr_accessor :name, :city_name, :ap
  validates  :iata_code, presence: true, length: { is: 3 }, uniqueness: true
  validates  :icao_code, presence: true, length: { is: 4 }
  validates  :name_eng, presence: true, length: { minimum: 2 }
  validates  :name_rus, presence: true, length: { minimum: 2 }
  validates  :iso_code, presence: true, length: { is: 2 }
  validates  :country_id, presence: true, numericality: { only_integer: true }

#  def name end

#  def city_name end

  def apdata
    "#{name_rus}, #{iata_code}, г.#{city_rus} (#{city_eng})"
  end

  def coordinate
    "#{latitude}, #{longitude}"
  end

  def self.ap_distance(airport1, airport2)
#    @airport1 = Airport.find(airport1) if airport1 != nil
#    @airport2 = Airport.find(airport2) if airport2 != nil
    if airport1 != nil || airport2 != nil
      p1 = GeoPoint.new  airport1.latitude.to_f, airport1.longitude.to_f
      p2 = GeoPoint.new  airport2.latitude.to_f, airport2.longitude.to_f
#      return p1, p2
      return p1.distance_to(p2), p1.bearing_to(p2)
      #@sbear = @p1.bearing_to(@p2)
#      ap_distance_return(@p1, @p2)
#      ap_sbear_return(@p1, @p2)
    end
  end

  def dist(p1, p2)
    p1.distance_to(p2)
  end

  def sbear(p1, p2)
    p1.bearing_to(p2)
  end

  def self.search(ap)
    if ap && ap != "" && ap != " "
      where('name_rus LIKE ? or name_eng LIKE ? or city_rus LIKE ? or city_eng LIKE ? or ICAO_code LIKE ? or IATA_code LIKE ?', "%#{ap}%", "%#{ap}%", "%#{ap}%", "%#{ap}%", "%#{ap}%", "%#{ap}%")
    else
      all
    end
  end
end
