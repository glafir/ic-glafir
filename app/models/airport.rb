class Airport < ActiveRecord::Base
include ActiveModel::Validations
acts_as_mappable :default_units => :kms,
                   :default_formula => :flat,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
  paginates_per 20
  has_one :apkey, dependent: :destroy
  has_many :aircompanies, dependent: :destroy
  belongs_to :town
  belongs_to :airport_state
  belongs_to :airport_air_traffic
  has_many :runway_aps, dependent: :destroy
  has_many :timetableaps, dependent: :destroy, foreign_key: "way_start"
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

  def self.search(ap)
    if ap && ap != ""
      where('name_rus LIKE ? or name_eng LIKE ? or city_rus LIKE ? or city_eng LIKE ? or ICAO_code LIKE ? or IATA_code LIKE ?', "%#{ap}%", "%#{ap}%", "%#{ap}%", "%#{ap}%", "%#{ap}%", "%#{ap}%")
    else
      all
    end
  end
end
