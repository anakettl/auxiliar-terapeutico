class CreateTherapists < ActiveRecord::Migration[7.0]
  def change
    create_table :therapists do |t|
      t.string :name
      t.datetime :dt_nasc
      t.references :user, index: true

      t.timestamps
    end
  end
end
