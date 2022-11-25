class AddColumnsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :bank_name, :string
    add_column :orders, :bank_card_number, :string
    add_column :orders, :bank_real_name, :string
  end
end
