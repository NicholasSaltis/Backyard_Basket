json.extract! profile, :id, :user_name, :first_name, :last_name, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
