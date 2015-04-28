class Timetableap < ActiveRecord::Base
  belongs_to :aircompany
  belongs_to :airport, foreign_key: "way_start"
#  belongs_to :airport, class_name: "Apkey", foreign_key: "way_end"
  belongs_to :apkey,  foreign_key: "way_end"
  has_many :timetableapSub, dependent: :destroy
  attr_accessible :aircompany_id, :DateOfEndNav, :DateOfStartNav, :Flight_Number, :GateEnd, :GateStart, :TermEnd, :TermStart, :TimeEnd, :TimeStart, :TypeOfPlane, :e0, :e1, :e2, :e3, :e4, :e5, :e6, :s0, :s1, :s2, :s3, :s4, :s5, :s6, :way_end, :way_start
  validates  :aircompany_id, presence: true, numericality: { only_integer: true }
  validates  :way_start, presence: true, numericality: { only_integer: true }
  validates  :way_end, presence: true, numericality: { only_integer: true }
  validates  :DateOfEndNav, presence: true
  validates  :DateOfStartNav, presence: true
  validates  :Flight_Number, presence: true, numericality: { only_integer: true },
                  length: { in: 1..4 },
                  uniqueness: { scope: :aircompany_id, message: "should happen once per year" }


  def self.search(start_ap,end_ap,search_al)
    if start_ap
      where('way_start LIKE ? and way_end LIKE ? and aircompany_id LIKE ?', "%#{start_ap}%",  "%#{end_ap}%",  "%#{search_al}%")
    else
      scoped
    end
  end

  def self.ufnumber
    
  end

  def aircompany_airline_name_rus
    aircompany.airline_name_rus if aircompany
  end

  def aircompany_airline_name_rus(airline_name_rus)
    self.aircompany = Aircompany.find_by_Airline_name_rus(airline_name_rus) unless airline_name_rus.blank?
  end
end
