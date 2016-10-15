class Gallery < ApplicationRecord
  has_many :gallery_types, :through => :gallery_join_gallery_types
  has_many :gallery_join_gallery_types

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

end
