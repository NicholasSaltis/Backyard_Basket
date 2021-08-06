json.extract! product, :id, :name, :description, :organic, :harvested_date, :expiry_date, :stock, :price_per_unit, :profile_id, :created_at, :updated_at
json.url product_url(product, format: :json)
