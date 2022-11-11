class Address::Region < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, presence: true

  has_many :provinces
  has_many :districts
  has_many :city_municipalities
  has_many :barangays
end
