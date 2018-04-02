class RunwayApsController < ApplicationController
  before_action :set_runway_ap, only: [:show, :edit, :update, :destroy, :runway_calendar, :rasp_runway_day]

  def index
    @runway_aps = RunwayAp.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:per_page])
    authorize RunwayAp
    respond_with(@runway_aps)
  end

  def show
    authorize @runway_ap
    respond_with(@runway_ap)
  end

  def new
    @runway_ap = RunwayAp.new
    authorize @runway_ap
    respond_with(@runway_ap)
  end

  def edit
    authorize @runway_ap
  end

  def create
    @runway_ap = RunwayAp.new(params[:runway_ap])
    authorize @runway_ap
    @runway_ap.save
    respond_with(@runway_ap)
  end

  def update
    authorize @runway_ap
    @runway_ap.update_attributes(params[:runway_ap])
    respond_with(@runway_ap)
  end

  def destroy
    authorize @runway_ap
    @runway_ap.destroy
    respond_with(@runway_ap)
  end

  def runway_calendar
    authorize @runway_ap
    @date = params[:date] ? Date.parse(params[:date]) : redirect_to("/runway_aps/#{params[:id]}/calendar?date=#{Date.today}")
#    @date = params[:date] ? Date.parse(params[:date]) : Date.current
#    respond_with(@runway_ap)
  end
  
  def rasp_runway_day
    @arr = Array.new
    @date = Date.parse(params[:date])
	@time = Time.parse("00:00").to_time
	@day_current = @date.day
	@timetablesap_flights = TimetablesapFlight.where("runairport_start_id = :runairport_start_id OR runairport_finish_id = :runairport_finish_id",{:runairport_start_id => params[:id],:runairport_finish_id => params[:id]}).where(:start => (@date-1.day)..(@date+1.day)).where(:end => (@date-1.day)..(@date+1.day))
	1.step(288,1) do
      @timetablesap_flights.each do |timetablesap_flight|
        if timetablesap_flight.start.strftime("%H:%M")==@time.strftime("%H:%M") and timetablesap_flight.start.strftime("%Y-%m-%d").to_s==@date.to_s and timetablesap_flight.runairport_start_id==@runway_ap.id
		  @ac = timetablesap_flight.aircompany.IATA_code
		  @fl = timetablesap_flight.Flight_Number
		  @bcolor = "#1874CD"
		  @state = "Взлёт"
		  @arr.push [@time.strftime("%H:%M"),@fl,@ac,@bcolor,@state,timetablesap_flight]
		  @time+=5.minute
        elsif timetablesap_flight.end.strftime("%H:%M")==@time.strftime("%H:%M") and timetablesap_flight.end.strftime("%Y-%m-%d").to_s==@date.to_s and timetablesap_flight.runairport_finish_id==@runway_ap.id
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

  def set_runway_ap
    @runway_ap = RunwayAp.find(params[:id])
  end

  def runway_ap_params
    params.require(:runway_ap).permit(:airport_id, :runway_name,  :runway_data, :runway_elevation, :runway_length)
  end
end
