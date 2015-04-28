class Town < ActiveRecord::Base
  has_many :airports, inverse_of: :town
  attr_accessible :accent_city, :city, :country, :latitude, :longitude, :region, :city_rus

  def twdata
    "#{accent_city} (#{country})"
  end

  def self.search(search)
    if search
      where('country LIKE ? OR city LIKE ? OR accent_city LIKE ? OR region = ?', "%#{search}%", "%#{search}%", "%#{search}%",  "#{search}")
    else
      scoped
    end
  end
end
