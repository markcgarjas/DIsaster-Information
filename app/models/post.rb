class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :address, presence: true
  belongs_to :user

  has_many :comments
  has_many :post_type_ships
  has_many :types, through: :post_type_ships
end
