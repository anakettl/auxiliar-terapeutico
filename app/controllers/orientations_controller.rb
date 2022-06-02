class OrientationsController < ApplicationController
  def index
    @therapist = Therapist.find_by(user_id: current_user.id)

    unless @therapist.nil?
      @patient = @therapist.patients.find(params[:patient_id])

      @orientations = @patient.orientations.order(:created_at).page params[:page]
    else
      @patient = Patient.find_by(user_id: current_user.id)

      @orientations = @patient.orientations.where(active: true).order(:created_at).page params[:page]

      render 'index_patient'
    end
  end

  def new
    @patient = Patient.find(params[:patient_id])
  end

  def show
    @patient = Patient.find(params[:patient_id])

    @orientation = @patient.orientations.find(params[:id])
  end

  def create
    @orientation_instance = Orientation.new(orientation_params)

    if @orientation_instance.valid? && @orientation_instance.save!
      flash[:notice] = "Orientação: #{@orientation_instance.name} criada com sucesso"
      redirect_to patient_orientations_path
    else
      flash[:alert] = @orientation_instance.errors.messages[:name].first
      redirect_to patient_orientations_path
    end
  rescue StandardError => e
    flash[:alert] = "Houve um erro durante a criação da orientação"
    redirect_to new_patient_orientation_path
  end

  def orientation_params
    params.permit(:name, :description, :active, :patient_id)
  end
end
