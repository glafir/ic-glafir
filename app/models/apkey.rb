class Apkey < ActiveRecord::Base
  belongs_to :airport
  has_many :timeiableaps
  attr_accessible :airport_id
  validates  :airport_id, presence: true, numericality: { only_integer: true }
end
