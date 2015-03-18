# encoding: UTF-8
class RwTypestationsController < ApplicationController
# GET /rw_typestations
def index
@rw_typestations = RwTypestation.paginate :page => params[:page], :order => 'id'
  end

  # GET /rw_typestations/1
  def show
    @rw_typestation = RwTypestation.find(params[:id])
end

# GET /rw_typestations/new
def new
@rw_typestation = RwTypestation.new
end

# GET /rw_typestations/1/edit
def edit
@rw_typestation = RwTypestation.find(params[:id])
end

# POST /rw_typestations
def create
@rw_typestation = RwTypestation.new(params[:rw_typestation])

if @rw_typestation.save
redirect_to({:action => 'index'}, {:notice => 'Rw typestation Добавлена!'})
    else
      render :action, '"new"'
    end
  end

  # PUT /rw_typestations/1
  def update
    @rw_typestation = RwTypestation.find(params[:id])

if @rw_typestation.update_attributes(params[:rw_typestation])
redirect_to(@rw_typestation, :notice => 'Данные обновлены')
    else
      render :action, '"edit"'
    end
  end

  # DELETE /rw_typestations/1
  def destroy
    @rw_typestation = RwTypestation.find(params[:id])
@rw_typestation.destroy

redirect_to (rw_typestations_url)
  end
end
