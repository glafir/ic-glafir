class TimetableapSubsController < ApplicationController
layout "application_empty_1", :only => [:flight_state]
  def index
    @timetableap_subs = TimetableapSub.all
  end

  def show
    @timetableap_sub = TimetableapSub.find(params[:id])
  end

  def new
    @timetableap_sub = TimetableapSub.new
  end

  def edit
    @timetableap_sub = TimetableapSub.find(params[:id])
  end

  def flight_state
    @timetableap_sub = TimetableapSub.find(params[:id])
  end

  def create
    @timetableap_sub = TimetableapSub.new(params[:timetableap_sub])
    respond_to do |format|
      if @timetableap_sub.save
#	@timetableap_sub = TimetableapSub.last
        format.html { redirect_to @timetableap_sub, notice: 'Timetableap was successfully created.' }
        format.json { render json: @timetableap_sub, status: :created, location: @timetableap_sub }
      else
        format.html { render action: "new" }
        format.json { render json: @timetableap_subs.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @timetableap_sub = TimetableapSub.find(params[:id])
    respond_to do |format|
      if @timetableap_sub.update_attributes(params[:timetableap_sub])
        format.html { redirect_to @timetableap_sub, notice: 'Timetableap was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @timetableap_sub.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @timetableap_sub = TimetableapSub.find(params[:id])
    @timetableap_sub.destroy
    respond_to do |format|
      format.html { redirect_to timetableap_subs_url }
      format.json { head :no_content }
    end
  end
end
