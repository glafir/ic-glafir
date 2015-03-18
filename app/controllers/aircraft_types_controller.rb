class AircraftTypesController < ApplicationController
  # GET /aircraft_types
  # GET /aircraft_types.json
  def index
    @aircraft_types = AircraftType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aircraft_types }
    end
  end

  # GET /aircraft_types/1
  # GET /aircraft_types/1.json
  def show
    @aircraft_type = AircraftType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aircraft_type }
    end
  end

  # GET /aircraft_types/new
  # GET /aircraft_types/new.json
  def new
    @aircraft_type = AircraftType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aircraft_type }
    end
  end

  # GET /aircraft_types/1/edit
  def edit
    @aircraft_type = AircraftType.find(params[:id])
  end

  # POST /aircraft_types
  # POST /aircraft_types.json
  def create
    @aircraft_type = AircraftType.new(params[:aircraft_type])

    respond_to do |format|
      if @aircraft_type.save
        format.html { redirect_to @aircraft_type, notice: 'Aircraft type was successfully created.' }
        format.json { render json: @aircraft_type, status: :created, location: @aircraft_type }
      else
        format.html { render action: "new" }
        format.json { render json: @aircraft_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /aircraft_types/1
  # PUT /aircraft_types/1.json
  def update
    @aircraft_type = AircraftType.find(params[:id])

    respond_to do |format|
      if @aircraft_type.update_attributes(params[:aircraft_type])
        format.html { redirect_to @aircraft_type, notice: 'Aircraft type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aircraft_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aircraft_types/1
  # DELETE /aircraft_types/1.json
  def destroy
    @aircraft_type = AircraftType.find(params[:id])
    @aircraft_type.destroy

    respond_to do |format|
      format.html { redirect_to aircraft_types_url }
      format.json { head :no_content }
    end
  end
end
