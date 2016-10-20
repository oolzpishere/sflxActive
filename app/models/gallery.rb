class Gallery < ApplicationRecord
  has_attached_file :cover, styles: { crop: "480x340#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
    
  has_many :gallery_types, :through => :gallery_join_gallery_types
  has_many :gallery_join_gallery_types

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, presence: true
  validates :cover, presence: true

end
