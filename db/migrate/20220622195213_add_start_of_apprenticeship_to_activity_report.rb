class AddStartOfApprenticeshipToActivityReport < ActiveRecord::Migration[7.0]
  def change
    add_column :activity_reports, :start_of_apprenticeship, :date
  end
end
