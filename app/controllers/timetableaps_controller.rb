class TimetableapsController < ApplicationController
  before_action :set_timetableap, only: [:show, :edit, :update, :destroy, :update_dateoffinishdate, :flight_state]

  def index
    params[:fc_start] == nil ? @fc_start = Date.current : @fc_start = Date.civil(params[:fc_start][:year].to_i, params[:fc_start][:month].to_i,params[:fc_start][:day].to_i)
    params[:fc_end] == nil ? @fc_end = Date.current : @fc_end = Date.civil(params[:fc_end][:year].to_i, params[:fc_end][:month].to_i,params[:fc_end][:day].to_i)
    @timetableaps = Timetableap.search_start_ap(params[:timetableaps_path][:airport_start_id]).search_end_ap(params[:timetableaps_path][:airport_finish_id]).search_al(params[:timetableaps_path][:aircompany_id]).search_date(@fc_start,@fc_end).search_fn(params[:flight_number]).page(params[:page]).per(params[:limit])
    authorize @timetableaps
    respond_with(@timetableaps)
  end

  def search_tt
    authorize :timetableap
    @aircrafts = Aircraft.all
    if params['search_tt'].nil?
      if params['filter_tt'].nil?
        render action: 'search_tt'
      else
        @start = params['filter_tt']['town_start_id']
        @finish = params['filter_tt']['town_finish_id']
        @start_ap = params['filter_tt']['start_ap']
        @finish_ap = params['filter_tt']['finish_ap']
      end
    end
    if params['search_tt']
    if params['filter_tt'].nil?
      @start = params['search_tt']['town_start_id']
      @finish = params['search_tt']['town_finish_id']
      @start_ap = ''
      @finish_ap = ''
    end
    if params['search_tt']['town_start_id'] == '' || params['search_tt']['town_finish_id'] == ''
      render action: 'search_tt'
    else
      @ap1 = Town.find(params['search_tt']['town_start_id']).airports.first
      @ap2 = Town.find(params['search_tt']['town_finish_id']).airports.first
      @dist = Airport.ap_distance(@ap1,@ap2)
      @airports1 = Airport.where(town_id: params['search_tt']['town_start_id']).order(:name_rus)
      @airports2 = Airport.where(town_id: params['search_tt']['town_finish_id']).order(:name_rus)
      params['aircraft'].nil? ? params['aircraft'] == 18 : @aircraft = Aircraft.find(params['aircraft'])
      if @aircraft.aircraft_wake_category_id = 1
        @corr_time = 1000
      end
      if @aircraft.aircraft_wake_category_id = 2
        @corr_time = 1300
      end
      if @aircraft.aircraft_wake_category_id = 3
        @corr_time = 1900
      end
      @dist_time = (@dist[0]*1000) / (@aircraft.aircraft_maxspeed * 0.97 / 3.6) + @corr_time
    end
    end
    @timetableaps_all = Timetableap.where(:airport_start_id => Airport.select(:id).where(:town_id => @start)).where(:airport_finish_id => Airport.select(:id).where(:town_id => @finish))
    @timetableaps = @timetableaps_all.search_start_ap(@start_ap).search_end_ap(@finish_ap).page(params[:page]).per(params[:limit])
  end

  def validate
    timetableaps = Timetableaps.new(timetableaps_params)
    authorize @timetableap
    validator(timetableaps)
    respond_to do |format|
      format.json { render json: @errors }
    end
  end

  def admin_tt
    authorize :timetableap
  end

  def show
    authorize @timetableap
    respond_with(@timetableap)
  end

  def new
    @timetableap = Timetableap.new
    authorize @timetableap
    respond_with(@timetableap)
  end

  def update_dateoffinishdate
    authorize @timetableap
    render nothing: true
    if @timetableap.childs.count != 0
      @timetableap.childs.each do |c|
        c.update!(dateOfEndNav: @timetableap.dateOfEndNav + 1.year)
      end
    end
    flash[:notice] = "The flight ID=#{@timetableap.id} was prolong to #{@timetableap.DateOfEndNav}!" if @timetableap.update!(dateOfEndNav: @timetableap.dateOfEndNav + 1.year) && !request.xhr?
    flash_message_add
  end

  def edit
    authorize @timetableap
    respond_with(@timetableap)
  end

  def create
    @timetableap = Timetableap.new(timetableap_params)
    authorize @timetableap
    if @timetableap.save && !request.xhr?
      if (@timetableap.aircompany.airport_id != @timetableap.airport_finish_id) && (Aphub.where(aircompany_id: @timetableap.aircompany_id).where(airport_id: @timetableap.airport_finish_id).count == 0)
        aphub = Aphub.new
        aphub.aircompany_id = @timetableap.aircompany_id
        aphub.airport_id = @timetableap.airport_finish_id
        aphub.hub_type = 0
        aphub.save
      end
      flash[:notice] = "The flight #{@timetableap.id} was saved!"
      @flash_message_state_id = 401
      @flash = flash[:notice]
    end
    respond_with(@timetableap)
  end

  def update
    authorize @timetableap
    flash[:notice] = "The flight #{@timetableap.id} was updated!" if @timetableap.update_attributes(timetableap_params) && !request.xhr?
    if @timetableap.childs.count != 0
      @timetableap.childs.each do |c|
        c.update!( :dateOfEndNav => @timetableap.dateOfEndNav,
                   :dateOfStartNav => @timetableap.dateOfStartNav, 
                   :timeEnd => @timetableap.timeEnd, 
                   :timeStart => @timetableap.timeStart, 
                   :aircraft_id => @timetableap.aircraft_id, 
                   :e0 => @timetableap.e0, 
                   :e1 => @timetableap.e1, 
                   :e2 => @timetableap.e2, 
                   :e3 => @timetableap.e3, 
                   :e4 => @timetableap.e4, 
                   :e5 => @timetableap.e5, 
                   :e6 => @timetableap.e6, 
                   :s0 => @timetableap.s0, 
                   :s1 => @timetableap.s1, 
                   :s2 => @timetableap.s2, 
                   :s3 => @timetableap.s3, 
                   :s4 => @timetableap.s4, 
                   :s5 => @timetableap.s5, 
                   :s6 => @timetableap.s6, 
                   :airport_finish_id => @timetableap.airport_finish_id, 
                   :airport_start_id => @timetableap.airport_start_id)
      end
    end
    @flash_message_state_id = 402
    @flash = flash[:notice]
    respond_with(@timetableap)
  end

  def destroy
    authorize @timetableap
    @timetableap.destroy
    @flash_message_state_id = 405
    respond_with(@timetableap)
  end

  def flight_state
    if @timetableap.timeEnd.hour < 14 or @timetableap.timeStart.hour < 14
      @timetableap.timeEnd = @timetableap.timeEnd.change( :year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
      @timetableap.timeStart = @timetableap.timeStart.change( :year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
    else
      @timetableap.timeEnd = @timetableap.timeEnd.change( :year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
      @timetableap.timeStart = @timetableap.timeStart.change( :year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
    end
    @wheather_airport_start = Openweather2.get_weather(lat: @timetableap.airport_start.latitude, lon: @timetableap.airport_start.longitude)
    @wheather_airport_finish = Openweather2.get_weather(lat: @timetableap.airport_finish.latitude, lon: @timetableap.airport_finish.longitude)
    authorize @timetableap
    render layout: "application_empty_1"
  end

private
  def set_timetableap
    @timetableap = Timetableap.find(params[:id])
  end

  def sort_column
    Timetableap.column_names.include?(params[:sort]) ? params[:sort] : "flight_number"
  end

  def timetableap_params
    params.require(:timetableap).permit(:aircompany_id, :dateOfEndNav, :dateOfStartNav, :flight_number, :GateEnd, :GateStart, :TermEnd, :TermStart, :timeEnd, :timeStart, :aircraft_id, :e0, :e1, :e2, :e3, :e4, :e5, :e6, :s0, :s1, :s2, :s3, :s4, :s5, :s6, :airport_finish_id, :airport_start_id, :parent_id)
  end
end
