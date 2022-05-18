class DashboardController < ApplicationController
  def index
    @therapist = Therapist.find_by(user_id: current_user.id)

    unless @therapist.nil?
      @patients = @therapist.patients.page params[:page]

      render 'patients/index'
    else
      @patient = Patient.find_by(user_id: current_user.id)

      @training = @patient.trainings.find_by(active: true)

      @executions_today = @training&.executions&.where(created_at: Date.today.all_day)

      render 'dashboard/index'
    end
  end
end
