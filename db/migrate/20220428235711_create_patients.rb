class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.datetime :dt_nasc
      t.datetime :dt_atend
      t.text :resume
      t.string :phone
      t.references :user, index: true

      t.timestamps
    end
  end
end
