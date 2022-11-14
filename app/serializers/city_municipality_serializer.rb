class CityMunicipalitySerializer < ActiveModel::Serializer
  attributes :name, :district, :id

  def region
    object.district.name
  end
end
