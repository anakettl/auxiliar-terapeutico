class ExercisesController < ApplicationController
  def new
    @exercise = Exercise.new

    @therapist = Therapist.find_by(user_id: current_user.id)
  end

  def create
    @exercise = Exercise.create!(exercise_params)

    flash[:notice] = "Exercício: #{@exercise.name} criado com sucesso"
    redirect_to exercises_path
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
