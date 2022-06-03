json.extract! activity,
  :id,
  :team_id,
  :duration_of_work,
  :place_of_training,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_activity_url(activity, format: :json)
