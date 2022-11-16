class Address::Region < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, presence: true

  has_many :provinces
  has_many :districts
  has_many :posts, class_name: 'Post', foreign_key: 'address_region_id'

  default_scope { order(name: :asc) }
end
