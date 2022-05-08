class ExercisesController < ApplicationController
  def new
    @exercise = Exercise.new

    @therapist = Therapist.find_by(user_id: current_user.id)
  end

  def create
    if Exercise.create(exercise_params)
      redirect_to exercises_path
    else
      redirect_to new_exercise_path
    end
  end

  def index
    @therapist = Therapist.find_by(user_id: current_user.id)

    @exercises = @therapist.exercises.page params[:page]
  end

  def exercise_params
    params.require(:exercise).permit(:name, :description, :therapist_id, :video)
  end
end
