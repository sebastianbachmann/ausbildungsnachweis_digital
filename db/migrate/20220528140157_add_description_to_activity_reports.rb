class AddDescriptionToActivityReports < ActiveRecord::Migration[7.0]
  def change
    add_column :activity_reports, :description, :text
  end
end
