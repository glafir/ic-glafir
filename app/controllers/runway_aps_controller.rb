# -*- encoding : utf-8 -*-
class RunwayApsController < ApplicationController
  helper_method :sort_column, :sort_direction
  # GET /runway_aps
  # GET /runway_aps.wy_e
  def index
    @runway_aps = RunwayAp.joins('JOIN airports ON airports.id = runway_aps.airport_id').order(sort_column + " " + sort_direction).paginate :page => 
params[:page]

    respond_to do |format|
      format.html # index.html.er
      format.json { render json: @runway_aps }
    end
  end

  # GET /runway_aps/1
  # GET /runway_aps/1.json
  def show
    @runway_ap = RunwayAp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @runway_ap }
    end
  end

  # GET /runway_aps/new
  # GET /runway_aps/new.json
  def new
    @runway_ap = RunwayAp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @runway_ap }
    end
  end

  # GET /runway_aps/1/edit
  def edit
    @runway_ap = RunwayAp.find(params[:id])
  end

  # POST /runway_aps
  # POST /runway_aps.json
  def create
    @runway_ap = RunwayAp.new(params[:runway_ap])

    respond_to do |format|
      if @runway_ap.save
        format.html { redirect_to @runway_ap, notice: 'Runway ap was successfully created.' }
        format.json { render json: @runway_ap, status: :created, location: @runway_ap }
      else
        format.html { render action: "new" }
        format.json { render json: @runway_ap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /runway_aps/1
  # PUT /runway_aps/1.json
  def update
    @runway_ap = RunwayAp.find(params[:id])

    respond_to do |format|
      if @runway_ap.update_attributes(params[:runway_ap])
        format.html { redirect_to @runway_ap, notice: 'Runway ap was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @runway_ap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /runway_aps/1
  # DELETE /runway_aps/1.json
  def destroy
    @runway_ap = RunwayAp.find(params[:id])
    @runway_ap.destroy

    respond_to do |format|
      format.html { redirect_to runway_aps_url }
      format.json { head :no_content }
    end
  end

  def runway_calendar
    @runway_ap = RunwayAp.find(params[:id])	
	@date = params[:date] ? Date.parse(params[:date]) : redirect_to("/runway_aps/#{params[:id]}/calendar?date=#{Date.today}")
  end
  
  def rasp_runway_day
    @arr = Array.new
    @runway_ap = RunwayAp.find(params[:id])
    @date = Date.parse(params[:date])
	@time = Time.parse("00:00").to_time
	@day_current = @date.day
	@timetablesap_flights = TimetablesapFlight.where("runway_start = :runway_start OR runway_end = :runway_end",{:runway_start => params[:id],:runway_end => params[:id]}).where(:start => (@date-1.day)..(@date+1.day)).where(:end => (@date-1.day)..(@date+1.day))
	1.step(288,1) do
      @timetablesap_flights.each do |timetablesap_flight|
        if timetablesap_flight.start.strftime("%H:%M")==@time.strftime("%H:%M") and timetablesap_flight.start.strftime("%Y-%m-%d").to_s==@date.to_s and timetablesap_flight.runway_start==@runway_ap.id
		  @ac = timetablesap_flight.aircompany.IATA_code
		  @fl = timetablesap_flight.Flight_Number
		  @bcolor = "#1874CD"
		  @state = "Взлёт"
		  @arr.push [@time.strftime("%H:%M"),@fl,@ac,@bcolor,@state,timetablesap_flight]
		  @time+=5.minute
        elsif timetablesap_flight.end.strftime("%H:%M")==@time.strftime("%H:%M") and timetablesap_flight.end.strftime("%Y-%m-%d").to_s==@date.to_s and timetablesap_flight.runway_end==@runway_ap.id
		  @ac = timetablesap_flight.aircompany.IATA_code
		  @fl = timetablesap_flight.Flight_Number          
		  @bcolor = "#CD661D"
		  @state = "Посадка"
		  @arr.push [@time.strftime("%H:%M"),@fl,@ac,@bcolor,@state,timetablesap_flight]
		  @time+=5.minute
		else
		  @fl = nil
		  @ac = nil		  
          @bcolor = '#008B00'
		  @state = 'свободно'
		end
      end
	  @arr.push [@time.strftime("%H:%M"),@fl,@ac,@bcolor,@state]
	  @time+=5.minute
	  break if @time.strftime("%H:%M") == '00:00'
    end
  end
  
private
  def sort_column
    RunwayAp.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
end
