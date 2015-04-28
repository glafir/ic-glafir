# encoding: UTF-8
class RwStationsController < ApplicationController
# GET /rw_stations
def index
@rw_stations = RwStation.paginate :page => params[:page], :order => 'rw_zone'
  end

  # GET /rw_stations/1
  def show
    @rw_station = RwStation.find(params[:id])
end

# GET /rw_stations/new
def new
@rw_station = RwStation.new
end

# GET /rw_stations/1/edit
def edit
@rw_station = RwStation.find(params[:id])
end

# POST /rw_stations
def create
@rw_station = RwStation.new(params[:rw_station])

if @rw_station.save
redirect_to({:action => 'index'}, {:notice => 'Rw station добавлен'})
    else
      render :action, '"new"'
    end
  end

  # PUT /rw_stations/1
  def update
    @rw_station = RwStation.find(params[:id])

if @rw_station.update_attributes(params[:rw_station])
redirect_to(@rw_station, :notice => 'Вы действительно хотите удалить эту запись? Будьте ОСТОРОЖНЫ!')
    else
      render :action, '"edit"'
    end
  end

  # DELETE /rw_stations/1
  def destroy
    @rw_station = RwStation.find(params[:id])
@rw_station.destroy

redirect_to (rw_stations_url)
  end
end
