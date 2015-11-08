class TimetableapSubsController < ApplicationController
  before_filter :set_timetableap_sub, only: [:show, :edit, :update, :destroy, :flight_state]
  layout "application_empty_1", :only => [:flight_state]

  def index
    @timetableap_subs = TimetableapSub.page(params[:sub_page]).per(params[:per_page])
    authorize TimetableapSub
    respond_with(@timetableap_subs)
  end

  def show
    authorize @timetableap_sub
    respond_with(@timetableap_sub)
  end

  def new
    @timetableap_sub = TimetableapSub.new
    authorize @timetableap_sub
    respond_with(@timetableap_sub)
  end

  def edit
    authorize @timetableap_sub
  end

  def flight_state
    authorize @timetableap_sub
    respond_with(@timetableap_sub)
  end

  def create
    @timetableap_sub = TimetableapSub.new(params[:timetableap_sub])
    @timetableap_sub.save
    flash[:notice] = "The flight was saved!" if @timetableap_sub.save && !request.xhr?
    authorize @timetableap_sub
    respond_with(@timetableap_sub)
  end

  def update
    @timetableap_sub.update_attributes(params[:timetableap_sub])
    flash[:notice] = "The flight was uodated!" if @timetableap_sub.update_attributes(params[:timetableap_sub]) && !request.xhr?
    authorize @timetableap_sub
    respond_with(@timetableap_sub)
  end

  def destroy
    @timetableap_sub.destroy
    authorize @timetableap_sub
    respond_with(@timetableap_sub)
  end

private
  def set_timetableap_sub
    @timetableap_sub = TimetableapSub.find(params[:id])
  end
end
