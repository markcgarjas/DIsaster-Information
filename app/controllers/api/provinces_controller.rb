class Api::ProvincesController < ApplicationController

  def index
    region = Address::Region.find(params[:region_id])
    if region.code == "130000000"
      districts = region.districts
      render json: districts, each_serializer: DistrictSerializer
    else
      provinces = region.provinces
      render json: provinces, each_serializer: ProvinceSerializer
    end
  end
end
