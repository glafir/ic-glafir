class Timetableap < ActiveRecord::Base
include ActiveModel::Validations
  paginates_per 100
  has_many :timetableap_subs
  belongs_to :aircompany, inverse_of: :timetableaps, :counter_cache => true
  belongs_to :aircraft
  belongs_to :airport_start, class_name: "Airport", foreign_key: "way_start"
    scope :ordered_by_airport_start_city_rus, -> { joins(:airport_start).order('airports.city_rus') }
  belongs_to :airport_finish, class_name: "Airport", foreign_key: "way_end"
    scope :ordered_by_airport_finish_city_rus, -> { joins(:airport_finish).order('airports.city_rus') }
  has_many :childs, class_name: "Timetableap",
                          foreign_key: "parent_id"
  belongs_to :parent, class_name: "Timetableap"


  attr_accessible :aircompany_id, :dateOfEndNav, :dateOfStartNav, :flight_number, :GateEnd, :GateStart, :TermEnd, :TermStart, :timeEnd, :timeStart, :aircraft_id, :e0, :e1, :e2, :e3, :e4, :e5, :e6, :s0, :s1, :s2, :s3, :s4, :s5, :s6, :way_end, :way_start, :parent_id
  attr_accessor :f_tw, :f_ap, :s_tw, :s_ap, :timeIN, :bgcolor, :fstatus, :airline, :bgcolor_apload, :flight

  validates  :aircompany_id, presence: true, numericality: { only_integer: true }
  validates  :way_start, presence: true, numericality: { only_integer: true }
  validates  :way_end, presence: true, numericality: { only_integer: true }
  validates  :dateOfEndNav, presence: true
  validates  :dateOfStartNav, presence: true
  validates  :timeStart, presence: true
  validates  :timeEnd, presence: true
  validates  :flight_number, presence: true, numericality: { only_integer: true },
                    length: { maximum: 9999 },
                  uniqueness: { scope: :aircompany_id, message: "This Flight is exist!" }

  validates  :parent_id, uniqueness: { scope: :id, message: "This SubFlight is exist!" }

  def flight
    [aircompany.iata_code, flight_number].join(' ')
  end

  def flight=(flight)
    split = flight.split(' ', 2)
    self.aircompany.iata_code = split.first
    self.flight_number = split.last
  end

  def time_start
    if timeStart.hour < 24 - (DateTime.current.in_time_zone(airport_start.time_zone).utc_offset / 3600)
      timeStart.change(:year=>Time.now.in_time_zone(airport_start.time_zone).year, :month=>Time.now.in_time_zone(airport_start.time_zone).month, :day=>Time.now.in_time_zone(airport_start.time_zone).day)
    else
      timeStart.change(:year=>(Time.now.in_time_zone(airport_start.time_zone)-1.day).year, :month=>(Time.now.in_time_zone(airport_start.time_zone)-1.day).month, :day=>(Time.now.in_time_zone(airport_start.time_zone)-1.day).day)
    end
  end

  def time_finish
    if timeEnd.hour < 24 - (DateTime.current.in_time_zone(airport_finish.time_zone).utc_offset / 3600)
      timeEnd.change(:year=>Time.now.in_time_zone(airport_finish.time_zone).year, :month=>Time.now.in_time_zone(airport_finish.time_zone).month, :day=>Time.now.in_time_zone(airport_finish.time_zone).day)
    else
      timeEnd.change(:year=>(Time.now.in_time_zone(airport_finish.time_zone)-1.day).year, :month=>(Time.now.in_time_zone(airport_finish.time_zone)-1.day).month, :day=>(Time.now.in_time_zone(airport_finish.time_zone)-1.day).day)
    end
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
