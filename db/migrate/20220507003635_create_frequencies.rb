class CreateFrequencies < ActiveRecord::Migration[7.0]
  def change
    create_table :frequencies do |t|
      t.integer :repetition
      t.integer :time
      t.integer :series
      t.references :exercise, index: true
      t.references :training, index: true

      t.timestamps
    end
  end
end
