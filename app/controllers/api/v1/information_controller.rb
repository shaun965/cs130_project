class Api::V1::InformationController < Api::V1::BaseController
  protect_from_forgery prepend: true
  before_action :authenticate_doctor_request!, only: [:create, :index, :show]

  def index
  	response = []
  	current_doctor.patients.each do |patient|
  		response << {patient: patient, blood_sugar: patient.blood_sugars, blood_pressure: patient.blood_pressures, blood_fat: patient.blood_fat, dr: patient.dr_scores}
  	end

  	success_response 200, "Successfully pulled", {response: response}
  end

  def show
  	patient = current_doctor.patients.where(id: params[:id]).first

  	if patient
	  response = {patient: patient, blood_sugar: patient.blood_sugars, blood_pressure: patient.blood_pressures, blood_fat: patient.blood_fat, dr: patient.dr_scores}
	  success_response 200, "Successfully pulled", {response: response}
	else
  	  error_response 401, "Failed to pull", {}
	end

  end

  def create

  	patient = Patient.where(email: params[:email]).first
  	unless params[:blood_fat][:number].blank?
  		blood_fat = BloodFat.new(blood_fat_params)
  		blood_fat.patient = patient
  		unless blood_fat.save
  			error_response 401, "Blood Fat Failed", blood_fat.errors
  		end
  	end

  	unless params[:blood_sugar][:number].blank?
  		blood_sugar = BloodSugar.new(blood_sugar_params)
  		blood_sugar.patient = patient
  		unless blood_sugar.save
  			error_response 401, "Blood Sugar Failed", blood_sugar.errors
  		end
  	end

  	unless params[:blood_pressure][:high].blank?
  		blood_pressure = BloodPressure.new(blood_pressure_params)
  		blood_pressure.patient = patient
  		unless blood_pressure.save
  			error_response 401, "Blood Pressure Failed", blood_pressure.errors
  		end
  	end

  	unless params[:DR][:left_score].blank?
  		dr = DrScore.new(dr_params)
  		dr.patient = patient
  		unless dr.save
  			error_response 401, "DR Failed", dr.errors
  		end
  	end

	success_response 200, "Information Successfully uploaded", json: {}

  end

  private

  def blood_sugar_params
	{number: params[:blood_sugar][:number]}
  end

  def blood_fat_params
  	{number: params[:blood_fat][:number]}
  end

  def blood_pressure_params
  	{high: params[:blood_pressure][:high], low: params[:blood_pressure][:low]}
  end

  def dr_params
  	dr_parameter = params[:DR]
  	{left_score: dr_parameter[:left_score], right_score: dr_parameter[:right_score], left_note: dr_parameter[:left_note], right_note: dr_parameter[:right_note], left_photo: dr_parameter[:left_photo], right_photo: dr_parameter[:right_photo]}
  end

end
