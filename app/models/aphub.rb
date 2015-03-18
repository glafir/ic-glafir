class Aphub < ActiveRecord::Base
  attr_accessible :aircompany_id, :airport_id
  belongs_to :aircompany
  belongs_to :airport
end
