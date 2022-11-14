class CityMunicipalityProvinceSerializer < ActiveModel::Serializer
  attributes :name, :province, :id

  def region
    object.province.name
  end
end
