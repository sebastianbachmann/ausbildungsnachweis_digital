class Api::V1::ActivityReportSerializer < Api::V1::ApplicationSerializer
  set_type "activity_report"

  attributes :id,
    :team_id,
    :title,
    :place_of_training,
    :duration_of_work,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :team, serializer: Api::V1::TeamSerializer
end
