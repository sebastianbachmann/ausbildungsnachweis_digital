json.extract! activity_report,
  :id,
  :team_id,
  :title,
  :place_of_training,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_activity_report_url(activity_report, format: :json)
