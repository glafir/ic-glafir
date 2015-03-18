class Apkey < ActiveRecord::Base
  belongs_to :airport
  has_many :timeiableaps
  attr_accessible :airport_id
end
