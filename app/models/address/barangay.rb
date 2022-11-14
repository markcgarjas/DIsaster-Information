class Address::Barangay < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, presence: true

  belongs_to :region
  belongs_to :province
  belongs_to :district
  belongs_to :city_municipality

  default_scope { order(name: :asc) }
end
