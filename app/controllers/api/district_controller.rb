class Api::DistrictController < ApplicationController
  def index
    province = Address::Province.find(params[:province_id])
    districts = province.districts
    render json: districts, each_serializer: DistrictSerializer
  end
end
