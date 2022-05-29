class ExercisesController < ApplicationController
  def new
    @exercise = Exercise.new

    @therapist = Therapist.find_by(user_id: current_user.id)
  end

  def create
    @exercise_instance = Exercise.new(exercise_params)

    if @exercise_instance.valid? && @exercise_instance.save!
      flash[:notice] = "Exercício: #{@exercise.name} criado com sucesso"
      redirect_to exercises_path
    else
      flash[:alert] = @exercise_instance.errors.messages[:video].first
      redirect_to new_exercise_path
    end
  rescue StandardError => e
    flash[:alert] = "Houve um erro durante a criação do exercício"
    redirect_to new_exercise_path
  end

  def index
    @therapist = Therapist.find_by(user_id: current_user.id)

    @exercises = @therapist.exercises.page params[:page]
  end

  def exercise_params
    params.require(:exercise).permit(:name, :description, :therapist_id, :video)
  end
end
