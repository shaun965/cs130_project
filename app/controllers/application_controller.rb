class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	private

	# jwt token encryption
	def payload(doctor)
		return nil unless doctor and doctor.id
		{
		  auth_token: JsonWebToken.encode({doctor_id: doctor.id}),
		  doctor: {id: doctor.id, email: doctor.email}
		}
	end

	def get_token(doctor)
		JsonWebToken.encode({doctor_id: doctor.id})
	end

end
