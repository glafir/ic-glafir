class FlightTypesController < ApplicationController
  # GET /flight_types
  # GET /flight_types.json
  def index
    @flight_types = FlightType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @flight_types }
    end
  end

  # GET /flight_types/1
  # GET /flight_types/1.json
  def show
    @flight_type = FlightType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flight_type }
    end
  end

  # GET /flight_types/new
  # GET /flight_types/new.json
  def new
    @flight_type = FlightType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @flight_type }
    end
  end

  # GET /flight_types/1/edit
  def edit
    @flight_type = FlightType.find(params[:id])
  end

  # POST /flight_types
  # POST /flight_types.json
  def create
    @flight_type = FlightType.new(params[:flight_type])

    respond_to do |format|
      if @flight_type.save
        format.html { redirect_to @flight_type, notice: 'Flight type was successfully created.' }
        format.json { render json: @flight_type, status: :created, location: @flight_type }
      else
        format.html { render action: "new" }
        format.json { render json: @flight_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /flight_types/1
  # PUT /flight_types/1.json
  def update
    @flight_type = FlightType.find(params[:id])

    respond_to do |format|
      if @flight_type.update_attributes(params[:flight_type])
        format.html { redirect_to @flight_type, notice: 'Flight type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @flight_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flight_types/1
  # DELETE /flight_types/1.json
  def destroy
    @flight_type = FlightType.find(params[:id])
    @flight_type.destroy

    respond_to do |format|
      format.html { redirect_to flight_types_url }
      format.json { head :no_content }
    end
  end
end
