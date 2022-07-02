class Account::ActivityReportsController < Account::ApplicationController
  account_load_and_authorize_resource :activity_report, through: :team, through_association: :activity_reports

  # GET /account/teams/:team_id/activity_reports
  # GET /account/teams/:team_id/activity_reports.json
  def index
    # if you only want these objects shown on their parent's show page, uncomment this:
    # redirect_to [:account, @team]
  end

  # GET /account/activity_reports/:id
  # GET /account/activity_reports/:id.json
  def show
  end

  # GET /account/teams/:team_id/activity_reports/new
  def new
  end

  # GET /account/activity_reports/:id/edit
  def edit
  end

  # POST /account/teams/:team_id/activity_reports
  # POST /account/teams/:team_id/activity_reports.json
  def create
    respond_to do |format|
      if @activity_report.save
        format.html { redirect_to [:account, @team, :activity_reports], notice: I18n.t("activity_reports.notifications.created") }
        format.json { render :show, status: :created, location: [:account, @activity_report] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @activity_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/activity_reports/:id
  # PATCH/PUT /account/activity_reports/:id.json
  def update
    respond_to do |format|
      if @activity_report.update(activity_report_params)
        format.html { redirect_to [:account, @activity_report], notice: I18n.t("activity_reports.notifications.updated") }
        format.json { render :show, status: :ok, location: [:account, @activity_report] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @activity_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/activity_reports/:id
  # DELETE /account/activity_reports/:id.json
  def destroy
    @activity_report.destroy
    respond_to do |format|
      format.html { redirect_to [:account, @team, :activity_reports], notice: I18n.t("activity_reports.notifications.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_report_params
    strong_params = params.require(:activity_report).permit(
      :title,
      :description,
      :apprentice_firstname,
      :apprentice_lastname,
      :year_of_training,
      :start_of_apprenticeship,
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.
    )

    assign_date(strong_params, :start_of_apprenticeship)
    # 🚅 super scaffolding will insert processing for new fields above this line.

    strong_params
  end
end
