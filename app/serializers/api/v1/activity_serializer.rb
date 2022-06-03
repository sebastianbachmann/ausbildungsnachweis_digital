class Api::V1::ActivitySerializer < Api::V1::ApplicationSerializer
  set_type "activity"

  attributes :id,
    :team_id,
    :duration_of_work,
    :place_of_training,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :team, serializer: Api::V1::TeamSerializer
end
