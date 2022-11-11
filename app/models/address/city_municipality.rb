class Address::CityMunicipality < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, presence: true

  belongs_to :region
  belongs_to :province
  belongs_to :district

  has_many :barangays
end
