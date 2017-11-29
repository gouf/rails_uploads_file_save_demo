json.extract! image, :id, :name, :path, :created_at, :updated_at
json.url image_url(image, format: :json)
