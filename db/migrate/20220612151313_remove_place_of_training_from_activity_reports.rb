class RemovePlaceOfTrainingFromActivityReports < ActiveRecord::Migration[7.0]
  def change
    remove_column :activity_reports, :place_of_training, :string
  end
end
