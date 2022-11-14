class RemoveReferencesNotNeeded < ActiveRecord::Migration[7.0]
  def change
    remove_reference :address_city_municipalities, :region
    remove_reference :address_barangays, :region
    remove_reference :address_barangays, :district
    remove_reference :address_barangays, :province
    remove_reference :address_districts, :province

  end
end
