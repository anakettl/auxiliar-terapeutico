class DashboardController < ApplicationController
  def index
    @therapist = Therapist.find_by(user_id: current_user.id)

    unless @therapist.nil?
      @patients = @therapist.patients.page params[:page]

      render 'patients/index'
    else
      @patient = Patient.find_by(user_id: current_user.id)

      render 'dashboard/index'
    end
  end
end