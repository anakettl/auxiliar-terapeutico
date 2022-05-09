class TrainingsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])

    @therapist = Therapist.find_by(user_id: current_user.id)

    @exercises = @therapist.exercises.order(:name)

    @training = Training.new
  end

  def index
    @patient = Patient.find(params[:patient_id])

    @trainings = @patient.trainings.order(:dt_start).page params[:page]
  end

  def create
    @therapist = Therapist.find_by(user_id: current_user.id)
    @patient = Patient.find(params[:patient_id])

    @exercises = @therapist.exercises.order(:name)

    active_training = @patient.trainings.find_by(active: true)

    @training = Training.create(training_params)

    frequencies.each do |frequency|
      Frequency.create(
        series: frequency[:series],
        time: frequency[:time],
        repetition: frequency[:repetition],
        exercise_id: frequency[:exercise_id],
        training_id: @training.id
      )
    end

    if @training.persisted?
      if @training.active?
        active_training.active = false
        active_training.save

        redirect_to patient_trainings_path
      end
    else
      redirect_to new_patient_training_path
    end
  end

  def training_params
    params.require(:training).permit(
      :patient_id,
      :title,
      :dt_start,
      :dt_end,
      :orientation,
      :active
    )
  end

  def frequencies
    @freq = []

    @exercises.each do |ex|
      @freq << params[:training][:"frequency_#{ex.id}"]
    end
    @freq.delete_if { |obj| obj[:series]  == "" && obj[:time]  == "" && obj[:repetition] == "" }
  end
end
