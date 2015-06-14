class Aircompany < ActiveRecord::Base
include ActiveModel::Validations
  paginates_per 10
  belongs_to :airport
  belongs_to :country
  has_many :timetableaps, dependent: :destroy
  has_many :timetableap_subs, dependent: :destroy
  has_many :timetableap_flights, dependent: :destroy
  has_many :aphubs, dependent: :destroy
  attr_accessible :awb_prefix, :airline_name_eng, :airline_name_rus, :airport_id, :iata_code, :icao_code, :al_start, :al_finish, :country_id
  validates  :iata_code, presence: true, length: { is: 2 }
  validates  :icao_code, presence: true, length: { is: 3 }
  validates  :airline_name_eng, presence: true, length: { minimum: 2 }
  validates  :airline_name_rus, presence: true, length: { minimum: 2 }
  validates  :airport_id, presence: true, numericality: { only_integer: true }
  validates  :country_id, presence: true, numericality: { only_integer: true }
  validates  :al_start, presence: true

  def self.search(search)
    if search
      where('airline_name_rus LIKE ? or airline_name_eng LIKE ? or icao_code LIKE ? or iata_code LIKE ?',"%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      all
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
