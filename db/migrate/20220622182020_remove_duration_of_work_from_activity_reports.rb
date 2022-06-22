class RemoveDurationOfWorkFromActivityReports < ActiveRecord::Migration[7.0]
  def change
    remove_column :activity_reports, :duration_of_work, :decimal
  end
end
