class AddUniqueStringToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :unique_string, :string
  end
end
