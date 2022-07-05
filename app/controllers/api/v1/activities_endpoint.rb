class Api::V1::ActivitiesEndpoint < Api::V1::Root
  helpers do
    params :team_id do
      requires :team_id, type: Integer, allow_blank: false, desc: "Team ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Activity ID"
    end

    params :activity do
      optional :description, type: String, desc: Api.heading(:description)
      optional :duration_of_work, type: String, desc: Api.heading(:duration_of_work)
      optional :place_of_training, type: String, desc: Api.heading(:place_of_training)
      optional :apprenticeship_training_framework, type: String, desc: Api.heading(:apprenticeship_training_framework)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "teams", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource Activity
    end

    #
    # INDEX
    #

    desc Api.title(:index), &Api.index_desc
    params do
      use :team_id
    end
    oauth2
    paginate per_page: 100
    get "/:team_id/activities" do
      @paginated_activities = paginate @activities
      render @paginated_activities, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :team_id
      use :activity
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:team_id/activities" do
      if @activity.save
        render @activity, serializer: Api.serializer
      else
        record_not_saved @activity
      end
    end
  end

  resource "activities", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource Activity
    end

    #
    # SHOW
    #

    desc Api.title(:show), &Api.show_desc
    params do
      use :id
    end
    oauth2
    route_param :id do
      get do
        render @activity, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :activity
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @activity.update(declared(params, include_missing: false))
          render @activity, serializer: Api.serializer
        else
          record_not_saved @activity
        end
      end
    end

    #
    # DESTROY
    #

    desc Api.title(:destroy), &Api.destroy_desc
    params do
      use :id
    end
    route_setting :api_resource_options, permission: :destroy
    oauth2 "delete"
    route_param :id do
      delete do
        render @activity.destroy, serializer: Api.serializer
      end
    end
  end
end
