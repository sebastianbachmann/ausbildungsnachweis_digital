class AddApprenticeLastnameToActivityReports < ActiveRecord::Migration[7.0]
  def change
    add_column :activity_reports, :apprentice_lastname, :string
  end
end
