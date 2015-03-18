class Aircompany < ActiveRecord::Base
  belongs_to :airport
  has_many :timetableaps, dependent: :destroy
  has_many :timetableap_subs, dependent: :destroy
  has_many :timetableap_flights, dependent: :destroy
  has_many :aphubs, dependent: :destroy
  attr_accessible :awb_prefix, :airline_name_eng, :airline_name_rus, :airport_id, :country, :iata_code, :icao_code, :al_start, :al_finish
#  cattr_reader :per_page
#  @@per_page = 10
  def self.search(search)
    if search
      where('airline_name_rus LIKE ? or airline_name_eng LIKE ? or icao_code LIKE ? or iata_code LIKE ?',"%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

#netzke_attribute :al_offline
  def al_online
    al_finish.blank?
  end

  def image
    image = "/images/air_tm/#{iata_code}.png"
  end
end
