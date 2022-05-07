class CreateTrainings < ActiveRecord::Migration[7.0]
  def change
    create_table :trainings do |t|
      t.string :title
      t.datetime :dt_start
      t.datetime :dt_end
      t.text :orientation
      t.references :patient, index: true

      t.timestamps
    end
  end
end
