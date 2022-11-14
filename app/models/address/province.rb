class Address::Province < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, presence: true

  belongs_to :region

  has_many :city_municipalities
  has_many :barangays

  default_scope { order(name: :asc) }
end
