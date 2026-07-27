class RwRoute < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :rw_start_route, class_name: "Station", foreign_key: "start_route"
  belongs_to :rw_end_route, class_name: "Station", foreign_key: "end_route"
  has_many :rw_eltrains_routes
  has_many :rw_eltrains_timetables, through: :rw_eltrains_routes
  validates  :start_route, presence: true, numericality: { only_integer: true }
  validates  :end_route, presence: true, numericality: { only_integer: true }
end

