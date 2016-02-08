class Timetableap < ActiveRecord::Base
include ActiveModel::Validations
  paginates_per 100
  has_many :timetableap_subs
  belongs_to :aircompany, inverse_of: :timetableaps, :counter_cache => true
  belongs_to :aircraft
  belongs_to :airport, foreign_key: "way_start"
#  belongs_to :airport, class_name: "Apkey", foreign_key: "way_end"
  belongs_to :apkey,  foreign_key: "way_end"
  has_many :timetableapSub, dependent: :destroy
  attr_accessible :aircompany_id, :DateOfEndNav, :DateOfStartNav, :Flight_Number, :GateEnd, :GateStart, :TermEnd, :TermStart, :TimeEnd, :TimeStart, :aircraft_id, :e0, :e1, :e2, :e3, :e4, :e5, :e6, :s0, :s1, :s2, :s3, :s4, :s5, :s6, :way_end, :way_start
  attr_accessor :twrus, :aprus, :f_twrus, :f_aprus, :s_twrus, :s_aprus, :timeIN, :bgcolor, :fstatus, :airline, :al_plane, :plane_al, :ap2, :timeEnd, :timeStart, :ap, :s_ap, :f_ap, :bgcolor_apload
  validates  :aircompany_id, presence: true, numericality: { only_integer: true }
  validates  :way_start, presence: true, numericality: { only_integer: true }
  validates  :way_end, presence: true, numericality: { only_integer: true }
  validates  :DateOfEndNav, presence: true
  validates  :DateOfStartNav, presence: true
  validates  :Flight_Number, presence: true, numericality: { only_integer: true },
                    length: { maximum: 9999 },
                  uniqueness: { scope: :aircompany_id, message: "should happen once per year" }

  def self.search_start_ap(start_ap)
    if start_ap && start_ap != ""
      where('way_start = ?', "#{start_ap}")
    else
      all
    end
  end

  def self.search_end_ap(end_ap)
    if end_ap && end_ap != ""
      where('way_end = ?', "#{end_ap}")
    else
      all
    end
  end

  def self.search_endtw(tw)
    if tw && tw != ""
      where(:way_end => Airport.select(:id).where("town_id = ?", "#{tw}"))
    else
      all
    end
  end

  def self.search_starttw(tw)
    if tw && tw != ""
      where(:way_start => Airport.select(:id).where("town_id = ?", "#{tw}"))
    else
      all
    end
  end

  def self.search_endcountry(con)
    if con && con != ""
      where(:way_end => Airport.select(:id).where("country_id = ?", "#{con}"))
    else
      all
    end
  end

  def self.search_startcountry(con)
    if con && con != ""
      where(:way_start => Airport.select(:id).where("country_id = ?", "#{con}"))
    else
      all
    end
  end


  def self.search_al(al)
    if al && al != ""
      where('aircompany_id = ?', "#{al}")
    else
      all
    end
  end

  def self.search_date(fc_start,fc_end)
    if fc_start || fc_end
      where('DateOfEndNav BETWEEN ? and ?', "#{fc_start}", "#{fc_end}")
    else
      all
    end
  end

  def self.search_fn(fnum)
    if fnum && fnum != ""
      where('Flight_Number = ?', "#{fnum}")
    else
      all
    end
  end

  def self.count_out(airport_id)
  end

  def self.count_in(airport_id)
  end

  def self.count_all(airport_id)
  end

  def aircompany_airline_name_rus
    aircompany.airline_name_rus if aircompany
  end

  def aircompany_airline_name_rus(airline_name_rus)
    self.aircompany = Aircompany.find_by_Airline_name_rus(airline_name_rus) unless airline_name_rus.blank?
  end
end
