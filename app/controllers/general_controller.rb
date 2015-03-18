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
    @tts = Timetableap.all
#    @tts.each do |tt|
#      tt.TimeStart = tt.TimeStart + 1.hour
#      tt.TimeEnd = tt.TimeEnd + 1.hour
#      tt.save
#    end
  end
end
