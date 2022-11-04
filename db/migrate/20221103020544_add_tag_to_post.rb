class AddTagToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :tag, :string
  end
end
