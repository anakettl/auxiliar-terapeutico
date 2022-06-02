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

  def show
    @therapist = Therapist.find_by(user_id: current_user.id)

    unless @therapist.nil?
      @patient = Patient.find(params[:patient_id])

      @training = Training.find(params[:id])

      render 'show_therapist'
    else
      @patient = Patient.find_by(user_id: current_user.id)

      @training = @patient.trainings.find_by(active: true)

      @frequencies = @training.frequencies.order(:name)
    end
  end

  def create
    @therapist = Therapist.find_by(user_id: current_user.id)
    @patient = Patient.find(params[:patient_id])

    @exercises = @therapist.exercises.order(:name)

    active_training = @patient.trainings.find_by(active: true)

    @training = Training.create!(training_params)

    frequencies.each do |frequency|
      Frequency.create!(
        series: frequency[:series],
        time: frequency[:time],
        repetition: frequency[:repetition],
        exercise_id: frequency[:exercise_id],
        training_id: @training.id
      )
    end

    if @patient.trainings.count == 1
      @training.activate!
    elsif @training.active?
      active_training.active = false
      active_training.save!
    end

    flash[:notice] = "Treino: #{@training.title} criado com sucesso"
    redirect_to patient_trainings_path
  rescue StandardError => e
    flash[:alert] = "Houve um erro durante a criação do treino"
    redirect_to new_patient_training_path
  end

  def update
    @therapist = Therapist.find_by(user_id: current_user.id)

    unless @therapist.nil?
    else
      @patient = Patient.find_by(user_id: current_user.id)

      @training = Training.find(params[:id])

      if Execution.all.empty?
        realization_group = 1
      else
        realization_group = Execution.all.where(training_id: @training.id).maximum(:realization_group)
        realization_group += 1
      end

      executions.each do |execution|
        Execution.create(
          comment: execution[:comment],
          realization_group: realization_group,
          exercise_id: execution[:exercise_id],
          training_id: @training.id
        )
      end

      redirect_to dashboard_path
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

  def executions
    @exec = []

    exercise_ids = params[:training][:exercise_ids].split(' ').map(&:to_i)

    @exercises = Exercise.where(id: exercise_ids)

    @exercises.each do |ex|
      @exec << params[:training][:"execution_#{ex.id}"]
    end

    @exec
  end
end
