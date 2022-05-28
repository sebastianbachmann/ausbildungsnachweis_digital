class CreateActivityReports < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_reports do |t|
      t.references :team, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
