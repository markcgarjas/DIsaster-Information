class Address::Barangay < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, presence: true

  belongs_to :city_municipality, optional: true
  has_many :posts, class_name: 'Post', foreign_key: 'address_barangay_id'

  default_scope { order(name: :asc) }
end
