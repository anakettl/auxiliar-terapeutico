class DashboardController < ApplicationController
  def index
    @therapist = Therapist.find_by(user_id: current_user.id)

    unless @therapist.nil?
      @patients = @therapist.patients.page params[:page]

      render 'patients/index'
    else
      @patient = Patient.find_by(user_id: current_user.id)

      @training = @patient.trainings.find_by(active: true)

      @realization_today = @training&.realizations&.where(date: Date.today.all_day)

      start_date = params.fetch(:start_date, Date.today).to_date
      @realizations = @patient.realizations.where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week, )

      render 'dashboard/index'
    end
  end
end
