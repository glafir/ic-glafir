class AircraftWakeCategoriesController < ApplicationController
  # GET /aircraft_wake_categories
  # GET /aircraft_wake_categories.json
  def index
    @aircraft_wake_categories = AircraftWakeCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aircraft_wake_categories }
    end
  end

  # GET /aircraft_wake_categories/1
  # GET /aircraft_wake_categories/1.json
  def show
    @aircraft_wake_category = AircraftWakeCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aircraft_wake_category }
    end
  end

  # GET /aircraft_wake_categories/new
  # GET /aircraft_wake_categories/new.json
  def new
    @aircraft_wake_category = AircraftWakeCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aircraft_wake_category }
    end
  end

  # GET /aircraft_wake_categories/1/edit
  def edit
    @aircraft_wake_category = AircraftWakeCategory.find(params[:id])
  end

  # POST /aircraft_wake_categories
  # POST /aircraft_wake_categories.json
  def create
    @aircraft_wake_category = AircraftWakeCategory.new(params[:aircraft_wake_category])

    respond_to do |format|
      if @aircraft_wake_category.save
        format.html { redirect_to @aircraft_wake_category, notice: 'Aircraft wake category was successfully created.' }
        format.json { render json: @aircraft_wake_category, status: :created, location: @aircraft_wake_category }
      else
        format.html { render action: "new" }
        format.json { render json: @aircraft_wake_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /aircraft_wake_categories/1
  # PUT /aircraft_wake_categories/1.json
  def update
    @aircraft_wake_category = AircraftWakeCategory.find(params[:id])

    respond_to do |format|
      if @aircraft_wake_category.update_attributes(params[:aircraft_wake_category])
        format.html { redirect_to @aircraft_wake_category, notice: 'Aircraft wake category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aircraft_wake_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aircraft_wake_categories/1
  # DELETE /aircraft_wake_categories/1.json
  def destroy
    @aircraft_wake_category = AircraftWakeCategory.find(params[:id])
    @aircraft_wake_category.destroy

    respond_to do |format|
      format.html { redirect_to aircraft_wake_categories_url }
      format.json { head :no_content }
    end
  end
end
