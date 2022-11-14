class Api::DistrictsController < ApplicationController

  def index
    region = Address::Region.find(params[:region_id])
    districts = region.districts
    render json: districts, each_serializer: DistrictSerializer
  end

end
