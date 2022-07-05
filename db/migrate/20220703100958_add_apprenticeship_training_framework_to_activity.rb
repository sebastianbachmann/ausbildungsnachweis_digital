class AddApprenticeshipTrainingFrameworkToActivity < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :apprenticeship_training_framework, :integer
  end
end
