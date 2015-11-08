class Apkey < ActiveRecord::Base
include ActiveModel::Validations
  belongs_to :airport
  has_many :timetableaps, dependent: :destroy, foreign_key: "way_end"
  attr_accessible :airport_id
  validates  :airport_id, presence: true, numericality: { only_integer: true }
end
