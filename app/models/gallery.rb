class Gallery < ApplicationRecord
  has_attached_file :cover, styles: { crop: "480x340#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
    
  has_many :gallery_types, :through => :gallery_join_gallery_types
  has_many :gallery_join_gallery_types

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, presence: true
  validates :cover, presence: true

  # elasticsearch =======================================
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mappings dynamic: 'false' do
    indexes :id
    indexes :title, analyzer: "ik_max_word", search_analyzer: "ik_max_word", type: 'string'
    indexes :body, analyzer: "ik_max_word", search_analyzer: "ik_max_word", type: 'string'
  end

  def as_indexed_json(options={})
    {
      "title" => title,
      "body" => body
    }
  end
  # ======================================================

  

end
