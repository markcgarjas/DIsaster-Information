class PostTypeShip < ApplicationRecord
  belongs_to :type
  belongs_to :post
end
