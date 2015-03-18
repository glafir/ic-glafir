# encoding: UTF-8
class TimetablesapFlight < ActiveRecord::Base
  belongs_to :aircompany
  attr_accessible :Flight_Number, :aircompany_id,  :GateEnd, :GateStart, :TermEnd, :TermStart, :TypeOfPlane, :way_end, :way_start, :runway_start, :runway_end, :start, :end, :flight_type_id 
end

