class Airport < ActiveRecord::Base
  has_one :apkey, dependent: :destroy
  has_many :aircompanies, dependent: :destroy
  belongs_to :town
  has_many :runway_aps, dependent: :destroy
  has_many :timetableaps, dependent: :destroy
  belongs_to :country, foreign_key: "iso_code"
  has_many :aphubs
  attr_accessible :Dist_to_town, :Terminals, :TerminalsColl, :city_eng, :city_rus, :email, :fax, :gmt_offset, :iata_code, :icao_code, :iso_code, :latitude, :longitude, :name_eng, :name_rus, :phone, :runnway_coll, :runway_elevation, :runway_length, :website, :town_id, :aircompanies_count
  validates  :iata_code, presence: true, length: { is: 3 }, uniqueness: true
  validates  :icao_code, presence: true, length: { is: 4 }
  validates  :name_eng, presence: true, length: { minimum: 2 }
  validates  :name_rus, presence: true, length: { minimum: 2 }
  validates  :iso_code, presence: true, length: { is: 2 }

  def apdata
    "#{name_rus} (#{iata_code})"
  end

  def self.search(search)
    if search
      where('name_rus LIKE ? or city_rus LIKE ? or city_eng LIKE ? or ICAO_code LIKE ? or IATA_code LIKE ? or town_id = ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "#{search}")
    else
      scoped
    end
  end

  def self.search_c(search)
    if search
      where('name_rus LIKE ? or name_eng LIKE ? or city_rus LIKE ? or city_eng LIKE ? or ICAO_code LIKE ? or IATA_code LIKE ? or town_id = ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%", "#{search}")
    else
      scoped
    end
  end
end
