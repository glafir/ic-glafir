class TimetableapSubsController < ApplicationController
  before_filter :set_timetableap_sub, only: [:show, :edit, :update, :destroy, :flight_state]
  layout "application_empty_1", :only => [:flight_state]

  def index
    @timetableap_subs = TimetableapSub.page(params[:sub_page]).per(params[:per_page])
    respond_with(@timetableap_subs)
  end

  def show
    respond_with(@timetableap_sub)
  end

  def new
    @timetableap_sub = TimetableapSub.new
    respond_with(@timetableap_sub)
  end

  def edit
  end

  def flight_state
    respond_with(@timetableap_sub)
  end

  def create
    @timetableap_sub.save
    flash[:notice] = "The flight was saved!" if @timetableap_sub.save && !request.xhr?
    respond_with(@timetableap_sub)
  end

  def update
    @timetableap_sub.update_attributes(params[:timetableap_sub])
    flash[:notice] = "The flight was uodated!" if @timetableap_sub.update_attributes(params[:timetableap_sub]) && !request.xhr?
    respond_with(@timetableap_sub)
  end

  def destroy
    @timetableap_sub.destroy
    respond_with(@timetableap_sub)
  end

  def set_timetableap_sub
    @timetableap_sub = TimetableapSub.find(params[:id])
  end
end
