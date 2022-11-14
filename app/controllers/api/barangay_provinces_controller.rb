class Api::BarangayProvincesController < ApplicationController

  def index
    city_municipality = Address::CityMunicipality.find(params[:city_municipality_province_id])
    barangays = city_municipality.barangays
    render json: barangays, each_serializer: BarangaySerializer
  end

end
