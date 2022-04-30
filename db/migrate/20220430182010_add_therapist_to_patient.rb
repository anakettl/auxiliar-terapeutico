class AddTherapistToPatient < ActiveRecord::Migration[7.0]
  def change
    add_reference :patients, :therapist, index: true
  end
end
