class Address::CityMunicipality < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, presence: true

  belongs_to :province, optional: true
  belongs_to :district, optional: true

  has_many :barangays

  default_scope { order(name: :asc) }
end
