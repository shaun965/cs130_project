class Api::V1::PatientController < Api::V1::BaseController
  protect_from_forgery prepend: true
  before_action :authenticate_doctor_request!, only: [:sign_up]

  def authenticate_patient
    patient = Patient.find_for_database_authentication(email: params[:email])
    if patient and patient.valid_password?(params[:password])
      success_response 200, "Login Success", json: payload(patient)
    else
      error_response 401, "Login Failed", 'Invalid Username/Password'
    end
  end

  def sign_up
    @patient = Patient.new(patient_params)
    @patient.doctors << current_doctor
    if @patient.save
      success_response 200, "Sign up Success", json: {}
    else
      error_response 401, "Sign up Failed", @patient.errors
    end
  end

  private

  def patient_params
    params.permit(:email, :password, :name, :birthdate, :height, :weight, :sex)
  end

end
