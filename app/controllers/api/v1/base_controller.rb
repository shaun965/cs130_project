class Api::V1::BaseController < ApplicationController

  protected

  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
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

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
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