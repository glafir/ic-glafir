# -*- encoding : utf-8 -*-
class GeneralController < ApplicationController
before_filter :authenticate_user!
layout "without_html", :only => [:timenow, :chnglocale]
##layout "general", :only => [:home, :rw, :air, :help]
  def login
  end
  
  def home  
      @usermenu = {}
      @usermenu["1"] = "Профиль."
  end
  def rw
      @usermenu = {}
      @usermenu["1"] = "Поезда дальнего следования."
      @usermenu["2"] = "Пригородные электропоезда."
      @usermenu["3"] = "Высокоскоростные аэроэкспрессы."
  end
  
  def help
      @usermenu = {}
      @usermenu["1"] = "Справка 1"
      @usermenu["2"] = "Справка 2"
      @usermenu["3"] = "Справка 3"
      @usermenu["4"] = "Справка 4"
  end

  def timenow
    @timeNOW = Time.zone.now
  end

  def chnglocale
  end

  def timecor
#    @als = Timetableap.where(aircompany_id: 10006).where(way_start: 18438)
#    @als.each { |al|
#       @all = Timetableap.where(aircompany_id: 10006).find_by_Flight_Number(al.Flight_Number + 1)
#       al['neew'] = @all.Flight_Number

#      @all.way_end = 25832
#      @all.save
#      al.way_start = 25832
#      al.save
#    }
  end

  def apcor
#    @c = Country.all
#    @c.each do |cc|
#      @towns = Town.where(country: "zr")
#      @towns.each do |t|
#        t.country_id = 323
#        t.country = 'cd'
#        t.save(:validate => false)
#      end
#    end
    @towns = Town.where(country_id: nil)
  end
end
