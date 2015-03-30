class TimetableapsController < ApplicationController
layout "application_empty_1", :only => [:flight_state]

  # GET /timetableaps
  # GET /timetableaps.json
  def index
    @timetableaps = Timetableap.select("*,(select city_rus from airports where airports.id = timetableaps.way_end) as city_rus_end,(select city_rus from airports where airports.id = timetableaps.way_start) as city_rus_start").search(params[:start_ap],params[:end_ap],params[:search_al])
  end

  def ttair_admin
    render layout: "application_empty_1"
  end

  # GET /timetableaps/1
  # GET /timetableaps/1.json
  def show
    @timetableap = Timetableap.find(params[:id])
  end

  # GET /timetableaps/new
  # GET /timetableaps/new.json
  def new
    @timetableap = Timetableap.new
  end

  def update_dateoffinishdate
    render nothing: true
    @timetableap = Timetableap.find(params[:id])
    @timetableap.DateOfEndNav = @timetableap.DateOfEndNav + 1.year
    @timetableap.save
  end

  # GET /timetableaps/1/edit
  def edit
    @timetableap = Timetableap.find(params[:id])
  end

  # POST /timetableaps
  # POST /timetableaps.json
  def create
    @timetableap = Timetableap.new(params[:timetableap])
    respond_to do |format|
      if @timetableap.save
	@timetableap = Timetableap.last
        format.html { redirect_to @timetableap, notice: 'Timetableap was successfully created.' }
        format.mobile { redirect_to @timetableap, notice: 'Timetableap was successfully created.' }
        format.json { render json: @timetableap, status: :created, location: @timetableap }
      else
        format.html { render action: "new" }
        format.mobile { render action: "new" }
        format.json { render json: @timetableap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /timetableaps/1
  # PUT /timetableaps/1.json
  def update
    @timetableap = Timetableap.find(params[:id])
    respond_to do |format|
      if @timetableap.update_attributes(params[:timetableap])
        format.html { redirect_to @timetableap, notice: 'Timetableap was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @timetableap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timetableaps/1
  # DELETE /timetableaps/1.json
  def destroy
    @timetableap = Timetableap.find(params[:id])
    @timetableap.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def flight_state
    @timetableap = Timetableap.find(params[:id])
    if @timetableap.TimeEnd.hour < 14 or @timetableap.TimeStart.hour < 14
      @timetableap['timeEnd'] = @timetableap.TimeEnd.change( :year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
      @timetableap['timeStart'] = @timetableap.TimeStart.change( :year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
    else
      @timetableap['timeEnd'] = @timetableap.TimeEnd.change( :year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
      @timetableap['timeStart'] = @timetableap.TimeStart.change( :year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
    end
  end

  def insert
    @timetableaps = Timetableap.all
    @timetableaps.each do |tt|
      tt << Time.now
    end
  end
end
