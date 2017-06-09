class Api::V1::DoctorController < Api::V1::BaseController
  protect_from_forgery prepend: true
  # before_action :authenticate_request!

  def authenticate_doctor
    doctor = Doctor.find_for_database_authentication(email: params[:email])
    if doctor and doctor.valid_password?(params[:password])
      success_response 200, "Login Success", json: payload(doctor)
    else
      error_response 401, "Login Failed", 'Invalid Username/Password'
    end
  end

  def sign_up
  	@doctor = Doctor.new(doctor_params)
  	if @doctor.save
  		success_response 200, "Sign up Success", json: payload(@doctor)
  	else
      error_response 401, "Sign up Failed", @doctor.errors
  	end
  end

  private

  def doctor_params
	  params.permit(:email, :password)
  end

end
