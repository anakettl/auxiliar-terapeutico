class CreateExecutions < ActiveRecord::Migration[7.0]
  def change
    create_table :executions do |t|
      t.text :comment
      t.references :realization, index: true
      t.references :exercise, index: true

      t.timestamps
    end
  end
end
