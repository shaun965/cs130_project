class Api::V1::PatientController < Api::V1::BaseController
  protect_from_forgery prepend: true
  # before_action :authenticate_request!

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
    if @patient.save
      success_response 200, "Sign up Success", json: payload(@patient)
    else
      error_response 401, "Sign up Failed", @patient.errors
    end
  end

end
