# encoding: UTF-8
class TimetablesapFlightsController < ApplicationController
# GET /timetablesap_flights
  def index
    @timetablesap_flights = TimetablesapFlight.paginate :page => params[:page], :order => 'id'
    authorize @timetablesap_flights
  end

  # GET /timetablesap_flights/1
  def show
    @timetablesap_flight = TimetablesapFlight.find(params[:id])
    authorize @timetablesap_flight
  end

# GET /timetablesap_flights/new
def new
  @timetablesap_flight = TimetablesapFlight.new
   authorize @timetablesap_flight 
end

# GET /timetablesap_flights/1/edit
  def edit
    @timetablesap_flight = TimetablesapFlight.find(params[:id])
    authorize @timetablesap_flight 
  end

# POST /timetablesap_flights
def create

@timetablesap_flight = TimetablesapFlight.new(params[:timetablesap_flight])
   authorize @timetablesap_flight 
if @timetablesap_flight.save
redirect_to({:action => 'index'}, {:notice => 'Timetablesap flight добавлен'})
    else
      render :action, '"new"'
    end
end

  # PUT /timetablesap_flights/1


  def update
    @timetablesap_flight = TimetablesapFlight.find(params[:id])
    authorize @timetablesap_flight 
    if @timetablesap_flight.update_attributes(params[:timetablesap_flight])
      redirect_to(@timetablesap_flight, :notice => 'Изменения внесены')
    else
      render :action, '"edit"'
    end
  end

  # DELETE /timetablesap_flights/1
  def destroy
    @timetablesap_flight = TimetablesapFlight.find(params[:id])
    authorize @timetablesap_flight
    @timetablesap_flight.destroy
    redirect_to (timetablesap_flights_url)
  end

  def form
    authorize :timetablesap_flight
    @arr = Array.new
  end
  
  def form_enter
    authorize :timetablesap_flight
  @startnavstart = DateTime.new(params[:StartNavStart][:year].to_i,params[:StartNavStart][:month].to_i,params[:StartNavStart][:day].to_i,params[:StartNavStart][:hour].to_i,params[:StartNavStart][:minute].to_i)
  @startnavend = DateTime.new(params[:StartNavEnd][:year].to_i,params[:StartNavEnd][:month].to_i,params[:StartNavEnd][:day].to_i,params[:StartNavEnd][:hour].to_i,params[:StartNavEnd][:minute].to_i)
  @endnavstart = DateTime.new(params[:EndNavStart][:year].to_i,params[:EndNavStart][:month].to_i,params[:EndNavStart][:day].to_i)

  if params[:Mo] == '1'
  (@startnavstart..@endnavstart).to_a.find_all{|dt| dt.strftime("%a")=="Mon"}.each do |s|
    ends = (s.to_time+(@startnavend.to_time - @startnavstart.to_time)).to_datetime
    @timetablesap_flight = TimetablesapFlight.new(:Flight_Number => params[:Flight_Number], :aircompany_id => params[:aircompany_id],  :airport_start_id => params[:airport_start_id], :airport_finish_id => params[:airport_finish_id], :TermStart => params[:TermStart], :TermEnd => params[:TermEnd], :GateStart => params[:GateStart], :GateEnd => params[:GateEnd], :TypeOfPlane => params[:TypeOfPlane], :start => s, :end => ends,:runairport_start_id => params[:runairport_start_id].to_i,:runairport_finish_id => params[:runairport_finish_id].to_i,:flight_type_id => 1)
	@timetablesap_flight.save
    end
	end
  if params[:Tu] == '1'
  (@startnavstart..@endnavstart).to_a.find_all{|dt| dt.strftime("%a")=="Tue"}.each do |s|
    ends = (s.to_time+(@startnavend.to_time - @startnavstart.to_time)).to_datetime
    @timetablesap_flight = TimetablesapFlight.new(:aircompany_id => params[:aircompany_id], :start => s, :end => ends, :Flight_Number => params[:Flight_Number], :airport_start_id => params[:airport_start_id], :airport_finish_id => params[:airport_finish_id], :TermStart => params[:TermStart], :TermEnd => params[:TermEnd], :GateStart => params[:GateStart], :GateEnd => params[:GateEnd], :TypeOfPlane => params[:TypeOfPlane],:runairport_start_id => params[:runairport_start_id].to_i,:runairport_finish_id => params[:runairport_finish_id].to_i,:flight_type_id => 1)
	@timetablesap_flight.save
    end	
	end
  if params[:We] == '1'
  (@startnavstart..@endnavstart).to_a.find_all{|dt| dt.strftime("%a")=="Wed"}.each do |s|
    ends = (s.to_time+(@startnavend.to_time - @startnavstart.to_time)).to_datetime
    @timetablesap_flight = TimetablesapFlight.new(:aircompany_id => params[:aircompany_id], :start => s, :end => ends, :Flight_Number => params[:Flight_Number], :airport_start_id => params[:airport_start_id], :airport_finish_id => params[:airport_finish_id], :TermStart => params[:TermStart], :TermEnd => params[:TermEnd], :GateStart => params[:GateStart], :GateEnd => params[:GateEnd], :TypeOfPlane => params[:TypeOfPlane],:runairport_start_id => params[:runairport_start_id].to_i,:runairport_finish_id => params[:runairport_finish_id].to_i,:flight_type_id => 1)
	@timetablesap_flight.save
    end
	end
  if params[:Th] == '1'
  (@startnavstart..@endnavstart).to_a.find_all{|dt| dt.strftime("%a")=="Thu"}.each do |s|
    ends = (s.to_time+(@startnavend.to_time - @startnavstart.to_time)).to_datetime
    @timetablesap_flight = TimetablesapFlight.new(:aircompany_id => params[:aircompany_id], :start => s, :end => ends, :Flight_Number => params[:Flight_Number], :airport_start_id => params[:airport_start_id], :airport_finish_id => params[:airport_finish_id], :TermStart => params[:TermStart], :TermEnd => params[:TermEnd], :GateStart => params[:GateStart], :GateEnd => params[:GateEnd], :TypeOfPlane => params[:TypeOfPlane],:runairport_start_id => params[:runairport_start_id].to_i,:runairport_finish_id => params[:runairport_finish_id].to_i,:flight_type_id => 1)
	@timetablesap_flight.save
    end	
	end
  if params[:Fr] == '1'
  (@startnavstart..@endnavstart).to_a.find_all{|dt| dt.strftime("%a")=="Fri"}.each do |s|
    ends = (s.to_time+(@startnavend.to_time - @startnavstart.to_time)).to_datetime
    @timetablesap_flight = TimetablesapFlight.new(:aircompany_id => params[:aircompany_id], :start => s, :end => ends, :Flight_Number => params[:Flight_Number], :airport_start_id => params[:airport_start_id], :airport_finish_id => params[:airport_finish_id], :TermStart => params[:TermStart], :TermEnd => params[:TermEnd], :GateStart => params[:GateStart], :GateEnd => params[:GateEnd], :TypeOfPlane => params[:TypeOfPlane],:runairport_start_id => params[:runairport_start_id].to_i,:runairport_finish_id => params[:runairport_finish_id].to_i,:flight_type_id => 1)
	@timetablesap_flight.save
    end	
	end
  if params[:Sa] == '1'
  (@startnavstart..@endnavstart).to_a.find_all{|dt| dt.strftime("%a")=="Sat"}.each do |s|
    ends = (s.to_time+(@startnavend.to_time - @startnavstart.to_time)).to_datetime
    @timetablesap_flight = TimetablesapFlight.new(:aircompany_id => params[:aircompany_id], :start => s, :end => ends, :Flight_Number => params[:Flight_Number], :airport_start_id => params[:airport_start_id], :airport_finish_id => params[:airport_finish_id], :TermStart => params[:TermStart], :TermEnd => params[:TermEnd], :GateStart => params[:GateStart], :GateEnd => params[:GateEnd], :TypeOfPlane => params[:TypeOfPlane],:runairport_start_id => params[:runairport_start_id].to_i,:runairport_finish_id => params[:runairport_finish_id].to_i,:flight_type_id => 1)
	@timetablesap_flight.save
    end	
  end
  if params[:Su] == '1'
  (@startnavstart..@endnavstart).to_a.find_all{|dt| dt.strftime("%a")=="Sun"}.each do |s|
    ends = (s.to_time+(@startnavend.to_time - @startnavstart.to_time)).to_datetime
    @timetablesap_flight = TimetablesapFlight.new(:aircompany_id => params[:aircompany_id], :start => s, :end => ends, :Flight_Number => params[:Flight_Number], :airport_start_id => params[:airport_start_id], :airport_finish_id => params[:airport_finish_id], :TermStart => params[:TermStart], :TermEnd => params[:TermEnd], :GateStart => params[:GateStart], :GateEnd => params[:GateEnd], :TypeOfPlane => params[:TypeOfPlane],:runairport_start_id => params[:runairport_start_id].to_i,:runairport_finish_id => params[:runairport_finish_id].to_i,:flight_type_id => 1)
	@timetablesap_flight.save
      end
    end
  end

  def some
  end  

private
  def timetablesap_flight_params
    params.require(:timetablesap_flight).permit(:flight_number, :aircompany_id,  :GateEnd, :GateStart, :TermEnd, :TermStart, :TypeOfPlane, :airport_finish_id, :airport_start_id, :runairport_start_id, :runairport_finish_id, :start, :end, :flight_type_id)
  end
end
