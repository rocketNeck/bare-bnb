class Photo < ApplicationRecord
  belongs_to :room

  has_attached_file :image,
                    :styles => { :medium => "300x300>", :thumb => "100x100>"},
                    :default_url => '/images/default-burning-house.jpg'
                    #there is a known bug in paperclip see room.rb for conditional
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
