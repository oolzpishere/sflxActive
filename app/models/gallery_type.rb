class GalleryType < ApplicationRecord
  has_many :galleries, :through => :gallery_join_gallery_types
  has_many :gallery_join_gallery_types
end
