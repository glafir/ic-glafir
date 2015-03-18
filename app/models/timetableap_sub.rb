class TimetableapSub < ActiveRecord::Base
  belongs_to :timetableap
  belongs_to :aircompany
##  belongs_to :airport, foreign_key: "way_start", dependent: :destroy
##  belongs_to :apkey, foreign_key: "way_end", dependent: :destroy
  attr_accessible :aircompany_id, :timetableap_id, :Flight_Number
end
