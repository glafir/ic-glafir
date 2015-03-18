# encoding: UTF-8
class RwRoutesController < ApplicationController
# GET /rw_routes
def index
@rw_routes = RwRoute.paginate :page => params[:page], :order => 'id'
  end

  # GET /rw_routes/1
  def show
    @rw_route = RwRoute.find(params[:id])
end

# GET /rw_routes/new
def new
@rw_route = RwRoute.new
end

# GET /rw_routes/1/edit
def edit
@rw_route = RwRoute.find(params[:id])
end

# POST /rw_routes
def create
@rw_route = RwRoute.new(params[:rw_route])

if @rw_route.save
redirect_to({:action => 'index'}, {:notice => 'Rw route создан'})
    else
      render :action, '"new"'
    end
  end

  # PUT /rw_routes/1
  def update
    @rw_route = RwRoute.find(params[:id])

if @rw_route.update_attributes(params[:rw_route])
redirect_to(@rw_route, :notice => 'Обновлено.')
    else
      render :action, '"edit"'
    end
  end

  # DELETE /rw_routes/1
  def destroy
    @rw_route = RwRoute.find(params[:id])
@rw_route.destroy

redirect_to (rw_routes_url)
  end
end
