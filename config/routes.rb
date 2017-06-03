Rails.application.routes.draw do
  devise_for :patients
  devise_for :doctors
  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: "home#index"

	namespace :api do
		namespace :v1 do
		  post 'auth_patient' => 'patient#authenticate_patient'
		  post 'auth_doctor' => 'doctor#authenticate_doctor'
		  post 'signup_doctor' => 'doctor#sign_up'
		end
	end

end
