json.extract! gallery, :id, :title, :body, :side_body, :position, :photos, :created_at, :updated_at
json.url gallery_url(gallery, format: :json)