class BarangaySerializer < ActiveModel::Serializer
  attributes :name, :city_municipality, :id

  def city_municipality
    object.city_municipality.name
  end

end
