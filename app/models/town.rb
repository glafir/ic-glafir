class Town < ActiveRecord::Base
include ActiveModel::Validations
acts_as_mappable :default_units => :kms,
                   :default_formula => :flat,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
  paginates_per 30
  has_many :users
  belongs_to :country
  has_many :airports, inverse_of: :town
  attr_accessible :accent_city, :city, :country_iso, :country_id, :latitude, :longitude, :region, :city_rus
  validates :country_id, presence: true, numericality: { only_integer: true }
  validates :accent_city, presence: true
  validates :city, presence: true

  def twdata
    "#{accent_city} (#{country_iso}, #{latitude}, #{longitude})"
  end

  def self.search(search)
    if search
      where('city LIKE ? OR accent_city LIKE ? OR region = ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def self.town_with_ap
    where(:id => Airport.select("town_id").where.not(town_id: nil))
  end
end
