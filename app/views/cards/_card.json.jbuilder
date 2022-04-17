json.extract! card, :id, :name, :description, :size, :status, :slug, :position, :project_id, :created_at, :updated_at
json.url card_url(card, format: :json)
