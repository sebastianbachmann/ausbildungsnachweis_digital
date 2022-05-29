class AddDurationOfWorkToActivityReports < ActiveRecord::Migration[7.0]
  def change
    add_column :activity_reports, :duration_of_work, :decimal
  end
end
