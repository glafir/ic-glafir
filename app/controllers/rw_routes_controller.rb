class RwRoutesController < ApplicationController
before_action :set_rw_route, only: [:show, :edit, :update, :destroy]
  def index
    @rw_routes = RwRoute.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:per_page])
    authorize @rw_routes
  end

  def admin_rw_routes
    authorize :rw_route
  end

  def show
    authorize @rw_route
  end

  def new
    @rw_route = RwRoute.new
    authorize @rw_route
  end

  def edit
  end

  def create
    @rw_route = RwRoute.new(rw_route_params)
    authorize @rw_route
    if @rw_route.save
      redirect_to({:action => 'index'}, {:notice => 'Rw route создан'})
    else
      render :action, '"new"'
    end
  end

  def update
    authorize @rw_route
    if @rw_route.update(rw_route_params)
      redirect_to(@rw_route, :notice => 'Обновлено.')
    else
      render :action, '"edit"'
    end
  end

  def destroy
    authorize @rw_route
    @rw_route.destroy
    redirect_to (rw_routes_url)
  end

  private
    def set_rw_route
      @rw_route = RwRoute.find(params[:id])
    end

    def sort_column
      RwRoute.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    def rw_route_params
      params.require(:rw_route).permit(:end_route, :start_route)
    end
end
