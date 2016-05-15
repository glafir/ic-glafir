class Timetableap < ActiveRecord::Base
include ActiveModel::Validations
  paginates_per 100
  has_many :timetableap_subs
  belongs_to :aircompany, inverse_of: :timetableaps, :counter_cache => true
  belongs_to :aircraft
  belongs_to :airport_start, class_name: "Airport", foreign_key: "way_start"
  belongs_to :airport_finish, class_name: "Airport", foreign_key: "way_end"
  has_many :childs, class_name: "Timetableap",
                          foreign_key: "parent_id"
  belongs_to :parent, class_name: "Timetableap"


  attr_accessible :aircompany_id, :dateOfEndNav, :dateOfStartNav, :flight_number, :GateEnd, :GateStart, :TermEnd, :TermStart, :timeEnd, :timeStart, :aircraft_id, :e0, :e1, :e2, :e3, :e4, :e5, :e6, :s0, :s1, :s2, :s3, :s4, :s5, :s6, :way_end, :way_start, :parent_id
  attr_accessor :f_tw, :f_ap, :s_tw, :s_ap, :timeIN, :bgcolor, :fstatus, :airline, :bgcolor_apload, :flight

  validates  :aircompany_id, presence: true, numericality: { only_integer: true }
  validates  :way_start, presence: true, numericality: { only_integer: true }
  validates  :way_end, presence: true, numericality: { only_integer: true }
  validates  :DateOfEndNav, presence: true
  validates  :DateOfStartNav, presence: true
  validates  :TimeStart, presence: true
  validates  :TimeEnd, presence: true
  validates  :flight_number, presence: true, numericality: { only_integer: true },
                    length: { maximum: 9999 },
                  uniqueness: { scope: :aircompany_id, message: "This Flight is exist!" }

  validates  :parent_id, uniqueness: { scope: :id, message: "This SubFlight is exist!" }

  def flight
    "#{aircompany.iata_code} #{flight_number}"
  end

  def time_str
#    "#{timeStart}"
    "#{timeStart.change(:year=>Time.now.in_time_zone('GMT').year, :month=>Time.now.in_time_zone('GMT').month, :day=>Time.now.in_time_zone('GMT').day)}"
  end

  def self.stoday
    @wday = Time.zone.now.strftime'%w'.to_s
    where("s#{@wday} = ?",1)
  end

  def self.etoday
    @wday = Time.zone.now.strftime'%w'.to_s
    where("e#{@wday} = ?",1)
  end

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
    self.aircompany = Aircompany.find_by_airline_name_rus(airline_name_rus) unless airline_name_rus.blank?
  end
end
