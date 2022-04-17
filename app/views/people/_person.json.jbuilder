json.extract! person, :id, :name, :initials, :slug, :created_at, :updated_at
json.url person_url(person, format: :json)
