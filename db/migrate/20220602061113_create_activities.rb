class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :team, null: false, foreign_key: true
      t.text :description
      t.decimal :duration_of_work
      t.string :place_of_training

      t.timestamps
    end
  end
end
