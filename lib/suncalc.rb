require 'date'
class SunCulc
  VERSION = '0.9.1'
  LATITUDE_DEFAULT= 53.4564
  LONGITUDE_DEFAULT= 138.8954
  RAD = Math::PI / 180.0
  PI = Math::PI
  DayMS = 1000 * 60 * 60 * 24
  J1970 = 2440588,
  J2000 = 2451545;

  attr_reader :nightEnd
  attr_reader :nauticalDawn
  attr_reader :dawn
  attr_reader :sunrise
  attr_reader :sunriseEnd
  attr_reader :goldenHourEnd
  attr_reader :solarNoon
  attr_reader :goldenHour
  attr_reader :sunsetStart
  attr_reader :sunset
  attr_reader :dusk
  attr_reader :nauticalDusk
  attr_reader :night

  def initialize(datetime, latitude=LATITUDE_DEFAULT, longitude=LONGITUDE_DEFAULT)
    @latitude, @longitude = latitude, longitude
    @julian_date = DateTime.jd(datetime.jd.to_f)
    @julian_day = @julian_date.jd.to_f #Shorthand for later use, where we want this value as a float.
    @zone = datetime.offset #datetime.utc_offset/86400 #time zone offset + daylight savings as a fraction of a day
    calcSun
  end


  def toJulian(date)
    return date.valueOf() / dayMs - 0.5 + J1970
  end

  def fromJulian(j)
    return new Date((j + 0.5 - J1970) * dayMs)
  end

  def toDays(date)
    return toJulian(date) - J2000
  end

end
