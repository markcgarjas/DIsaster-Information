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
  has_one :posts_count_preview
  mount_uploader :avatar, AvatarUploader
  belongs_to :region, class_name: 'Address::Region', foreign_key: 'address_region_id'
  belongs_to :province, class_name: 'Address::Province', foreign_key: 'address_province_id', optional: true
  belongs_to :city_municipality, class_name: 'Address::CityMunicipality', foreign_key: 'address_city_municipality_id'
  belongs_to :barangay, class_name: 'Address::Barangay', foreign_key: 'address_barangay_id'

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
