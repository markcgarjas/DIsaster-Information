class Post < ApplicationRecord
  include Discard::Model
  # default_scope {where(delete_at: nil)}

  validates :title, presence: true
  validates :content, presence: true
  validates :address, presence: true
  belongs_to :user

  has_many :comments
  has_many :post_type_ships
  has_many :types, through: :post_type_ships

  # def destroy
  #   update(delete_at: Time.now)
  # end
end
