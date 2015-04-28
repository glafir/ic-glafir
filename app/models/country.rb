class Country < ActiveRecord::Base
has_many :airports
has_many :towns
has_many :aircompanies
  attr_accessible :country_iata_code, :country_icao_code, :country_name, :country_number

  def self.search(search)
    if search
      where('country_name LIKE ? or country_iata_code LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end
