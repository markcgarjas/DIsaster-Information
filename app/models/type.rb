class Type < ApplicationRecord
  validates :name, presence: true
  has_many :comments
  has_many :post_type_ships
  has_many :posts, through: :post_type_ships


end
