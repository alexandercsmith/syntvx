json.extract! article, :id, :name, :slug, :description, :body, :published, :published_at, :featured, :deleted, :style, :created_at, :updated_at
json.url article_url(article, format: :json)
