class TimetableapsController < ApplicationController
  layout "application_empty_1", :only => [:flight_state, :ttair_admin]
  before_filter :set_timetableap, only: [:show, :edit, :update, :destroy, :update_dateoffinishdate, :flight_state]

  def index
    @timetableaps = Timetableap.search(params[:start_ap],params[:end_ap],params[:search_al]).page(params[:page]).per(params[:per_page])

    respond_with(@timetableaps)
  end

  def ttair_admin
  end

  def show
    respond_with(@timetableap)
  end

  def new
    @timetableap = Timetableap.new
    respond_with(@timetableap)
  end

  def update_dateoffinishdate
    render nothing: true
    @timetableap = Timetableap.find(params[:id])
    @timetableap.DateOfEndNav = @timetableap.DateOfEndNav + 1.year
    @timetableap.save
    respond_with(@timetableap)
  end

  def edit
    respond_with(@timetableap)
  end

  def create
    @timetableap = Timetableap.new(params[:timetableap])
    @timetableap.save
    flash[:notice] = "The flight was saved!" if @timetableap.save && !request.xhr?
    respond_with(@timetableap, :location => timetableap_path(@timetableap))
  end

  def update
    @timetableap.update_attributes(params[:timetableap])
    flash[:notice] = "The flight was updated!" if @timetableap.update_attributes(params[:timetableap]) && !request.xhr?
    respond_with(@timetableap, :location => timetableap_path(@timetableap))
  end

  def destroy
    @timetableap.destroy
    respond_with(@timetableap)
  end

  def flight_state
    if @timetableap.TimeEnd.hour < 14 or @timetableap.TimeStart.hour < 14
      @timetableap['timeEnd'] = @timetableap.TimeEnd.change( :year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
      @timetableap['timeStart'] = @timetableap.TimeStart.change( :year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
    else
      @timetableap['timeEnd'] = @timetableap.TimeEnd.change( :year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
      @timetableap['timeStart'] = @timetableap.TimeStart.change( :year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
    end
    respond_with(@timetableap)
  end

  def insert
    @timetableaps = Timetableap.all
    @timetableaps.each do |tt|
      tt << Time.now
    end
  end

private
  def set_timetableap
    @timetableap = Timetableap.find(params[:id])
  end
end
