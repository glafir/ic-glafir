class Aircompany < ActiveRecord::Base
include ActiveModel::Validations
mount_uploader :avatar, AvatarUploader
  paginates_per 30
  has_many :users
  has_many :airline_codeshares
  has_many :codeshares, class_name: "AirlineCodeshare", foreign_key: "codeshare_id"
  belongs_to :airport
  belongs_to :country
  has_many :timetableaps, dependent: :destroy, inverse_of: :aircompany
#  has_many :timetableap_flights, dependent: :destroy
  has_many :aphubs
  has_many :childs, class_name: "Aircompany",
                          foreign_key: "manager_id"
  belongs_to :manager, class_name: "Aircompany"
  has_many :airline_codeshares
  
#  attr_accessible :awb_prefix, :airline_name_eng, :airline_name_rus, :airport_id, :iata_code, :icao_code, :al_start, :al_finish, :country_id, :manager_id, :avatar, :avatar_cache
  attr_accessor :per_cent_tt
  validates :iata_code, presence: true, length: { is: 2 }
  validates :icao_code, presence: true, length: { is: 3 }
  validates :airline_name_eng, presence: true, length: { minimum: 2 }
  validates :airline_name_rus, presence: true, length: { minimum: 2 }
  validates :airport_id, presence: true, numericality: { only_integer: true }
  validates :country_id, presence: true, numericality: { only_integer: true }
  validates :al_start, presence: true

  def to_s
    airline_name_rus
  end

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

  def per_cent_tt
    tt_all = Timetableap.all
    (timetableaps.count.to_f / tt_all.count.to_f * 100).round(2)
  end
end
