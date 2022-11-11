class CreateAddressDistricts < ActiveRecord::Migration[7.0]
  def change
    create_table :address_districts do |t|
      t.string :code
      t.string :name
      t.references :region
      t.references :province
      t.timestamps
    end
  end
end
