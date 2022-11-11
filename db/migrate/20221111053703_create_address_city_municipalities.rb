class CreateAddressCityMunicipalities < ActiveRecord::Migration[7.0]
  def change
    create_table :address_city_municipalities do |t|
      t.string :code
      t.string :name
      t.references :region
      t.references :province
      t.references :district
      t.timestamps
    end
  end
end
