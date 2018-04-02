# -*- encoding : utf-8 -*-
class GeneralController < ApplicationController
before_action :authenticate_user!
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
#    @als = Timetableap.where(aircompany_id: 10006).where(airport_start_id: 18438)
#    @als.each { |al|
#       @all = Timetableap.where(aircompany_id: 10006).find_by_Flight_Number(al.Flight_Number + 1)
#       al['neew'] = @all.Flight_Number

#      @all.airport_finish_id = 25832
#      @all.save
#      al.airport_start_id = 25832
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

  def add_sub_tt
    authorize :general
    @act = Timetableap.where(aircompany_id: 10096)
    @act.each do |act|
      @act_sub = Timetableap.new
      @act_sub.aircompany_id = 10040
      @act_sub.parent_id = act.id
      @act_sub.airport_start_id = act.airport_start_id
      @act_sub.airport_finish_id = act.airport_finish_id
      @act_sub.aircraft_id = act.aircraft_id
      @act_sub.timeStart = act.timeStart
      @act_sub.timeEnd = act.timeEnd
      @act_sub.dateOfStartNav = act.dateOfStartNav
      @act_sub.dateOfEndNav = act.dateOfEndNav
      @act_sub.s1 = act.s1
      @act_sub.s2 = act.s2
      @act_sub.s3 = act.s3
      @act_sub.s4 = act.s4
      @act_sub.s5 = act.s5
      @act_sub.s6 = act.s6
      @act_sub.s0 = act.s0
      @act_sub.e1 = act.e1
      @act_sub.e2 = act.e2
      @act_sub.e3 = act.e3
      @act_sub.e4 = act.e4
      @act_sub.e5 = act.e5
      @act_sub.e6 = act.e6
      @act_sub.e0 = act.e0
      @act_sub.flight_number = "9#{act.flight_number+500}"
#      @act_sub.save
    end
  end
end
