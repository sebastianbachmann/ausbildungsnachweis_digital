class Account::ActivitiesController < Account::ApplicationController
  account_load_and_authorize_resource :activity, through: :team, through_association: :activities

  # GET /account/teams/:team_id/activities
  # GET /account/teams/:team_id/activities.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @team]
  end

  # GET /account/activities/:id
  # GET /account/activities/:id.json
  def show
  end

  # GET /account/teams/:team_id/activities/new
  def new
  end

  # GET /account/activities/:id/edit
  def edit
  end

  # POST /account/teams/:team_id/activities
  # POST /account/teams/:team_id/activities.json
  def create
    respond_to do |format|
      if @activity.save
        format.html { redirect_to [:account, @team, :activities], notice: I18n.t("activities.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @activity] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/activities/:id
  # PATCH/PUT /account/activities/:id.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to [:account, @activity], notice: I18n.t("activities.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @activity] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/activities/:id
  # DELETE /account/activities/:id.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @team, :activities], notice: I18n.t("activities.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_params
    strong_params = params.require(:activity).permit(
      :description,
      :duration_of_work,
      :place_of_training,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
