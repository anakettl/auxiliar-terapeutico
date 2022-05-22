class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.text :comment
      t.integer :grade, default: 0
      t.boolean :show, default: false
      t.references :execution, index: true

      t.timestamps
    end
  end
end
