class Address::District < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, presence: true

  belongs_to :region

  has_many :city_municipalities

  default_scope { order(name: :asc) }
end
