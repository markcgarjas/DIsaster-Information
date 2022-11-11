class CreateAddressBarangays < ActiveRecord::Migration[7.0]
  def change
    create_table :address_barangays do |t|
      t.string :code
      t.string :name
      t.references :region
      t.references :province
      t.references :district
      t.references :city_municipality
      t.timestamps
    end
  end
end
