class Town < ActiveRecord::Base
  has_many :airports, inverse_of: :town
  cattr_reader :per_page
  @@per_page = 50
  attr_accessible :accent_city, :city, :country, :latitude, :longitude, :region, :city_rus

  def self.search(search)
    if search
      where('country LIKE ? OR city LIKE ? OR accent_city LIKE ? OR region = ?', "%#{search}%", "%#{search}%", "%#{search}%",  "#{search}")
    else
      scoped
    end
  end
end
