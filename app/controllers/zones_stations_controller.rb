# encoding: UTF-8
class ZonesStationsController < ApplicationController
# GET /zones_stations
def index
@zones_stations = ZonesStation.paginate :page => params[:page], :order => 'id'
  end

  # GET /zones_stations/1
  def show
    @zones_station = ZonesStation.find(params[:id])
end

# GET /zones_stations/new
def new
@zones_station = ZonesStation.new
end

# GET /zones_stations/1/edit
def edit
@zones_station = ZonesStation.find(params[:id])
end

# POST /zones_stations
def create
@zones_station = ZonesStation.new(params[:zones_station])

if @zones_station.save
redirect_to({:action => 'index'}, {:notice => 'Zones station добавлен'})
    else
      render :action, '"new"'
    end
  end

  # PUT /zones_stations/1
  def update
    @zones_station = ZonesStation.find(params[:id])

if @zones_station.update_attributes(params[:zones_station])
redirect_to(@zones_station, :notice => 'Изменения внесены')
    else
      render :action, '"edit"'
    end
  end

  # DELETE /zones_stations/1
  def destroy
    @zones_station = ZonesStation.find(params[:id])
@zones_station.destroy

redirect_to (zones_stations_url)
  end
end