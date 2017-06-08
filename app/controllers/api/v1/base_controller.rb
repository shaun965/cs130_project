class Api::V1::BaseController < ApplicationController

  protected

  def authenticate_doctor_request!
    unless doctor_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_doctor = Doctor.find(auth_token[:doctor_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def authenticate_patient_request!
    unless patient_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_patient = Patient.find(auth_token[:patient_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end
  
  private

  # Helper method for authenticate_request!
  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def doctor_id_in_token?
    http_token && auth_token && auth_token[:doctor_id].to_i
  end

  def patient_id_in_token?
    http_token && auth_token && auth_token[:patient_id].to_i
  end

  # error and success response
  def success_response code, meta, data
    render  status: code,
            json: {
              meta: meta,
              data: data
            }
  end

  def error_response code, meta, errors
    render  status: code,
            json: {
              meta: meta,
              errors: errors
            }
  end

end