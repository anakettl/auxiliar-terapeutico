class AddColumnActiveToTrainings < ActiveRecord::Migration[7.0]
  def change
    add_column :trainings, :active, :boolean, :default => false
  end
end
