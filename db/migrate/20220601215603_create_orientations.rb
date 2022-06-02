class CreateOrientations < ActiveRecord::Migration[7.0]
  def change
    create_table :orientations do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :active, default: false
      t.references :patient, index: true, null: false

      t.timestamps
    end
  end
end
