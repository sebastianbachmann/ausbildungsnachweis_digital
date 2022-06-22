class AddYearOfTrainingToActivityReport < ActiveRecord::Migration[7.0]
  def change
    add_column :activity_reports, :year_of_training, :string
  end
end
