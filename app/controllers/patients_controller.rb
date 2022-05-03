class PatientsController < ApplicationController
  def new
    @patient = Patient.new
    @user = User.new
  end

  def create
    if Patient.create(patient_params) && User.create(user_params)
      redirect_to patients_path
    else
      redirect_to new_patient_path
    end
  end

  def index
    @therapist = Therapist.find_by(user_id: current_user.id)

    @patients = @therapist.patients.page params[:page]
  end

  def patient_params
    params.require(:patient).permit(:name, :dt_nasc, :dt_atend, :resume, :phone)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
