class AddPlaceOfTrainingToActivityReports < ActiveRecord::Migration[7.0]
  def change
    add_column :activity_reports, :place_of_training, :string
  end
end
