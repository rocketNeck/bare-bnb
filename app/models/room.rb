class Room < ApplicationRecord
  #TODO must validate the the room has a photo before generating the room.

  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :reviews

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
  validates :price, numericality: {only_integer: true, greater_than: 5}

  def show_first_photo(size = nil)
    if self.photos.length == 0
      #used conditional because default image for paperclip is buggy
      #TODO work on fixing paperclip default image bug-ness
      # it may make more sence to check if a model has a photo in the view and if not link to cloudinery default
      ActionController::Base.helpers.asset_path('default-burning-house.jpg')
    else
      self.photos[0].image.url(size)
    end
  end

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end
end
