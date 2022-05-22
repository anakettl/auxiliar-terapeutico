class ExecutionsController < ApplicationController
  def index
    @therapist = Therapist.find_by(user_id: current_user.id)

    unless @therapist.nil?
      @patient = Patient.find(params[:patient_id])

      @training = Training.find(params[:training_id])
      @realization_group = @training.
    else
    end
  end
end
