class Address::Region < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, presence: true

  has_many :provinces
  has_many :districts

  default_scope { order(name: :asc) }
end
