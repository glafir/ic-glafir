class TimetableapsController < ApplicationController
  layout "application_empty_1", :only => [:flight_state, :ttair_admin]
  before_filter :set_timetableap, only: [:show, :edit, :update, :destroy, :update_dateoffinishdate, :flight_state]

  def index
    params[:fc_start] == nil ? @fc_start = Date.current : @fc_start = Date.civil(params[:fc_start][:year].to_i, params[:fc_start][:month].to_i,params[:fc_start][:day].to_i)
    params[:fc_end] == nil ? @fc_end = Date.current : @fc_end = Date.civil(params[:fc_end][:year].to_i, params[:fc_end][:month].to_i,params[:fc_end][:day].to_i)
    @timetableaps = Timetableap.search_start_ap(params[:start_ap]).search_end_ap(params[:end_ap]).search_al(params[:search_al]).search_date(@fc_start,@fc_end).search_fn(params[:flight_number]).page(params[:page]).per(params[:limit])
    authorize @timetableaps
    respond_with(@timetableaps)
  end

  def search_tt
    @ap1 = Town.find(params[:start_ap]).airports.first if params[:start_ap] != nil
    @ap2 = Town.find(params[:end_ap]).airports.first if params[:end_ap] != nil
    if @ap1 != nil || @ap2 != nil
      @p1 = GeoPoint.new  @ap1.latitude.to_f, @ap1.longitude.to_f
      @p2 = GeoPoint.new  @ap2.latitude.to_f, @ap2.longitude.to_f
      @dist = @p1.distance_to(@p2)
      @sbear = @p1.bearing_to(@p2)
    end
    if params[:start_ap].nil? && params[:end_ap].nil?
      @timetableaps = Timetableap.page(params[:page]).per(params[:limit])
      render action: 'search_tt'
    else
      @timetableaps = Timetableap.where(:way_start => Airport.select(:id).where(:town_id => (params[:start_ap]))).where(:way_end => Airport.select(:id).where(:town_id => (params[:end_ap]))).page(params[:page]).per(params[:limit])
      @airports1 = Airport.where(town_id: params[:start_ap]).order(:name_rus)
      @airports2 = Airport.where(town_id: params[:end_ap]).order(:name_rus)
    end
    authorize :timetableap
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
    @timetableap = Timetableap.new(params[:timetableap])
    authorize @timetableap
    flash[:notice] = "The flight #{@timetableap.id} was saved!" if @timetableap.save && !request.xhr?
    @flash_message_state_id = 401
    @flash = flash[:notice]
    respond_with(@timetableap)
  end

  def update
    authorize @timetableap
    flash[:notice] = "The flight #{@timetableap.id} was updated!" if @timetableap.update_attributes(params[:timetableap]) && !request.xhr?
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
                   :way_end => @timetableap.way_end, 
                   :way_start => @timetableap.way_start)
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
    authorize @timetableap
    respond_with(@timetableap)
  end

private
  def set_timetableap
    @timetableap = Timetableap.find(params[:id])
  end

  def sort_column
    Timetableap.column_names.include?(params[:sort]) ? params[:sort] : "flight_number"
  end
end
