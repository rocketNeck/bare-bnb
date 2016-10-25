class Room < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :reservations

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 50}
  validates :address, presence: true
  validates :price, numericality: {only_integer:true, greater_than: 5}

  def show_first_photo(size)
    if self.photos.length == 0
      ActionController::Base.helpers.asset_path('default-burning-house.jpg')
    else
      self.photos[0].image.url(size)
    end
  end

end
