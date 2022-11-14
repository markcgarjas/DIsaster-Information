class Api::BarangaysController < ApplicationController

  def index
    city_municipality = Address::CityMunicipality.find(params[:city_municipality_id])
    barangays = city_municipality.barangays
    render json: barangays, each_serializer: BarangaySerializer
  end
end
