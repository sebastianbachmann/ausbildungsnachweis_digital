class Api::V1::ActivityReportSerializer < Api::V1::ApplicationSerializer
  set_type "activity_report"

  attributes :id,
    :team_id,
    :title,
    :place_of_training,
    :duration_of_work,
    :apprentice_firstname,
    :apprentice_lastname,
    :year_of_training,
    :start_of_apprenticeship,
    :end_of_apprenticeship,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :team, serializer: Api::V1::TeamSerializer
end
