class Aphub < ActiveRecord::Base
include ActiveModel::Validations
  attr_accessible :aircompany_id, :airport_id, :hub_type
  belongs_to :aircompany
  belongs_to :airport
    scope :ordered_by_airport_city_rus, -> { joins(:airport).order('airports.city_rus') }
  validates  :aircompany_id, presence: true, numericality: { only_integer: true }

  def self.where_airport_country(country,active)
    if active == 0
      joins(:airport).where("airports.country_id = ?", "#{country}")
    else
      joins(:airport).where("airports.country_id != ?", "#{country}")
    end
  end
#  validates  :airport_id, uniqueness: { scope: :aircompany_id, message: "This hub is already created"}
#  validates  :agency_id, uniqueness: { scope: :aircompany_id, message: "This agency is already created"}
end
