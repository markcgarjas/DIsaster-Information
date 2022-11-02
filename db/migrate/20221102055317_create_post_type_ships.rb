class CreatePostTypeShips < ActiveRecord::Migration[7.0]
  def change
    create_table :post_type_ships do |t|
      t.references :type
      t.references :post
      t.timestamps
    end
  end
end
