class ApiController < ApplicationController
before_filter :set_authtorize
  def getAirports
    @airports = Airport.where(country_id: 528)
    render json: @airports
  end

  def getCountries
    @countries = Country.all
    render json: @countries
  end
private
  def set_authtorize
    authorize :api
  end
end
