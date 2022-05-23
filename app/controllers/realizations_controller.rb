class RealizationsController < ApplicationController
  def index
    if current_user.therapist?
      @patient = Patient.find(params[:patient_id])
      @training = Training.find(params[:training_id])
      @realizations = @training.realizations.order(:date).page params[:page]
    else
      @patient = Patient.find_by(user_id: current_user.id)
      @training = Training.find(params[:training_id])
      @realizations = @training.realizations.order(:date).page params[:page]

      render 'index_patient'
    end
  end

  def new
    @patient = Patient.find_by(user_id: current_user.id)
    @training = Training.find(params[:training_id])
    @exercises = @training.exercises
    @realization = Realization.new
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
          exercise_id: execution[:exercise_id],
          video: execution[:video]
        )
      end
    end

    redirect_to dashboard_path
  end

  def show
    @patient = Patient.find(params[:patient_id])
    @training = Training.find(params[:training_id])
    @realization = Realization.find(params[:id])
    @executions = @realization.executions
    if current_user.patient?
      render 'show_patient'
    end
  end

  def update
    @realization = Realization.find(params[:id])

    feedbacks.each do |feedback|
      Feedback.create(
        grade: feedback[:grade],
        show: feedback[:show],
        comment: feedback[:comment],
        execution_id: feedback[:execution_id]
      )
    end

    redirect_to patient_training_realizations_path
  end

  def executions
    execs = []

    exercise_ids = params[:realization][:exercise_ids].split(' ').map(&:to_i)

    @exercises = Exercise.where(id: exercise_ids)

    @exercises.each do |ex|
      execs << params[:realization][:"execution_#{ex.id}"]
    end

    execs
  end

  def feedbacks
    feeds = []

    exercutions_ids = params[:realization][:executions_ids].split(' ').map(&:to_i)

    @executions = Execution.where(id: exercutions_ids)

    @executions.each do |ex|
      feeds << params[:realization][:"feedback_#{ex.id}"]
    end

    feeds
  end
end
