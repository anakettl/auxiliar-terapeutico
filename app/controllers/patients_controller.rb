class PatientsController < ApplicationController
  def index
    @therapist = Therapist.find_by(user_id: current_user.id)

    unless @therapist.nil?
      @patients = @therapist.patients.page params[:page]
    else
      redirect_to dashboard_path
    end
  end

  def new
    @patient = Patient.new
    @user = User.new
  end

  def create
    @user = User.create!(user_params)

    @therapist = Therapist.find_by(user_id: current_user.id)

    if @user.persisted?
      @patient_instance = Patient.new(patient_params)
      @patient_instance.user_id = @user.id
      @patient_instance.therapist_id = @therapist.id
      @patient_instance.save!

      flash[:notice] = "Paciente: #{@patient_instance.name} criado com sucesso"
      redirect_to patients_path
    end
  rescue StandardError => e
    flash[:alert] = "Houve um erro durante a criação do paciente"
    redirect_to new_patient_path
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def edit
    @patient = Patient.find(params[:id])
    @user = User.find(@patient.user_id)
  end

  def update
    @patient = Patient.find(params[:id])
    @user = User.find(@patient.user_id)

    if @patient.update!(patient_params)
      unless user_params[:password].blank? && user_params[:password_confirmation].blank?
        @user.update!(user_params)
      end
      flash[:notice] = "Paciente: #{@patient.name} atualizado com sucesso"
      redirect_to patients_path
    end
  rescue StandardError => e
    flash[:alert] = "Houve um erro para atualizar o paciente"
    redirect_to new_patient_path
  end

  def destroy
    @patient = Patient.find(params[:id])
    @user = User.find(@patient.user_id)

    if @patient.destroy! && @user.destroy!
      flash[:notice] = "Paciente deletado com sucesso"
      redirect_to dashboard_path
    end
  rescue StandardError => e
    flash[:alert] = "Houve um erro para deletar o paciente"
    redirect_to dashboard_path
  end

  def patient_params
    params.require(:patient).permit(:name, :dt_nasc, :dt_atend, :resume, :phone)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
