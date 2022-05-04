class AddTherapistToExercises < ActiveRecord::Migration[7.0]
  def change
    add_reference :exercises, :therapist, index: true
  end
end
