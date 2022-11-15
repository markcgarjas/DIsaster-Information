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
  mount_uploader :avatar, AvatarUploader

  after_validation :generate_short_string

  private

  def generate_short_string
    loop do
      @string_unique = sprintf "%04d", rand(2 - 9999)
      break unless Post.exists?(unique_string: @string_unique)
    end
    self.unique_string = @string_unique
  end

  # def destroy
  #   update(delete_at: Time.now)
  # end
end
