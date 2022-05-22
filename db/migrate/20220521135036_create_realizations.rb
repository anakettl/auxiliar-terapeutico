class CreateRealizations < ActiveRecord::Migration[7.0]
  def change
    create_table :realizations do |t|
      t.text :comment
      t.references :training, index: true
      t.datetime :date

      t.timestamps
    end
  end
end
