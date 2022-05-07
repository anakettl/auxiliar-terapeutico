class TrainingsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])

    @therapist = Therapist.find_by(user_id: current_user.id)

    @exercises = @therapist.exercises.order(:name)

    @training = Training.new
  end

  def index
  end

  def create
    @therapist = Therapist.find_by(user_id: current_user.id)

    @exercises = @therapist.exercises.order(:name)

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
      redirect_to patient_trainings_path
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
      :orientation
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
