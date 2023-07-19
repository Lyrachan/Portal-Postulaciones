json.extract! publication, :id, :name, :description, :created_at, :updated_at
json.url publication_url(publication, format: :json)
