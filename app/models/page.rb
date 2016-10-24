class Page < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mappings do
    indexes :id
    indexes :title, analyzer: "ik_max_word", search_analyzer: "ik_max_word", type: 'string'
    indexes :body, analyzer: "ik_max_word", search_analyzer: "ik_max_word", type: 'string'
  end
end
