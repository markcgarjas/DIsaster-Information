class Address::Region < ApplicationRecord
  validates :code, uniqueness: true
  validates :name, presence: true
end
