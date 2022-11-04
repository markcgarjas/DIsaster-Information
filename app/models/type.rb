class Type < ApplicationRecord
  validates :name, presence: true

  has_many :post_type_ships, dependent: :restrict_with_exception
  has_many :posts, through: :post_type_ships


end
