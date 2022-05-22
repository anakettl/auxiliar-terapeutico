class RealizationsController < ApplicationController
  def new
    @patient = Patient.find_by(user_id: current_user.id)
    @training = Training.find(params[:training_id])
    @exercises = @training.exercises
    @realization = Realization.new
  end

  def index
    @patient = Patient.find(params[:patient_id])
    @trainings = @patient.trainings.order(:dt_start).page params[:page]
  end

  def create
    @patient = Patient.find_by(user_id: current_user.id)
    @training = Training.find(params[:training_id])

    @realization = Realization.create(
      date: Date.today,
      training_id: @training.id
    )

    if @realization.persisted?
      executions.each do |execution|
        Execution.create(
          comment: execution[:comment],
          realization_id: @realization.id,
          exercise_id: execution[:exercise_id]
        )
      end
    end

    redirect_to dashboard_path
  end

  def executions
    @exec = []

    exercise_ids = params[:realization][:exercise_ids].split(' ').map(&:to_i)

    @exercises = Exercise.where(id: exercise_ids)

    @exercises.each do |ex|
      @exec << params[:realization][:"execution_#{ex.id}"]
    end

    @exec
  end
end
