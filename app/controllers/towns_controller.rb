class TownsController < ApplicationController
  # GET /towns
  # GET /towns.json
  def index
    @towns = Town.search(params[:search]).order(sort_column + " " + sort_direction)
    @towns = @towns.page(params[:page]).per(params[:per_page])
  end

  def apToTw
    @airports = Airport.all
    @airports.each do |airport|
      @apkey = Apkey.new
      @apkey.id = airport.id if apkey.id.blank?
      @apkey.airport_id = airport.id if apkey.airport_id.blank?
      @apkey.save
    end
  end

  # GET /towns/1
  # GET /towns/1.json
  def show
    @town = Town.find(params[:id])
    @airports = Airport.where(town_id: @town.id)
    @airports = @airports.page(params[:page]).per(params[:per_page])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @town }
    end
  end

  # GET /towns/new
  # GET /towns/new.json
  def new
    @town = Town.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @town }
    end
  end

  # GET /towns/1/edit
  def edit
    @town = Town.find(params[:id])
  end

  # POST /towns
  # POST /towns.json
  def create
    @town = Town.new(params[:town])

    respond_to do |format|
      if @town.save
        format.html { redirect_to @town, notice: 'Town was successfully created.' }
        format.json { render json: @town, status: :created, location: @town }
      else
        format.html { render action: "new" }
        format.json { render json: @town.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /towns/1
  # PUT /towns/1.json
  def update
    @town = Town.find(params[:id])

    respond_to do |format|
      if @town.update_attributes(params[:town])
        format.html { redirect_to @town, notice: 'Town was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @town.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /towns/1
  # DELETE /towns/1.json
  def destroy
    @town = Town.find(params[:id])
    @town.destroy

    respond_to do |format|
      format.html { redirect_to towns_url }
      format.json { head :no_content }
    end
  end

private
  def sort_column
    Town.column_names.include?(params[:sort]) ? params[:sort] : "country"
  end
end
