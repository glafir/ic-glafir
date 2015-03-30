class Aphub < ActiveRecord::Base
  attr_accessible :aircompany_id, :airport_id
  belongs_to :aircompany
  belongs_to :airport
  validates  :aircompany_id, presence: true, numericality: { only_integer: true }
  validates  :airport_id, presence: true, numericality: { only_integer: true }
end
