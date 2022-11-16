class Address::Province < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, presence: true

  belongs_to :region
  has_many :city_municipalities
  has_many :posts, class_name: 'Post', foreign_key: 'address_province_id'

  default_scope { order(name: :asc) }
end
