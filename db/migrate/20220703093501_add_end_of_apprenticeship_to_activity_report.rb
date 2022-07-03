class AddEndOfApprenticeshipToActivityReport < ActiveRecord::Migration[7.0]
  def change
    add_column :activity_reports, :end_of_apprenticeship, :date
  end
end
