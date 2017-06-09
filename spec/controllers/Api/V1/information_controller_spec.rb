require 'rails_helper'

RSpec.describe Api::V1::InformationController, :type => :controller do
  describe "CREATE new records" do

    it "authenticates valid doctor" do
      doctor = Doctor.create(email: "abc@example.com", password: "11111111")
      patient = Patient.create(email: "abc@example.com", password: "11111111", name: "aa", birthdate: Date.new(10, 10, 10), height: 1322, weight: 132, sex: "male")
      json = { :format => 'json', :params => { :email => "abc@example.com", :blood_sugar => {number: 12}, :blood_fat => {number: 12}, :blood_pressure => {high: 120, low: 70}, :DR => {left_score: 120, right_score: 120} } }
      request.headers['Authorization'] = JsonWebToken.encode({doctor_id: doctor.id})
      post :create, json
    end

  end

  describe "GET all records" do
    it "actually" do
      doctor = Doctor.create(email: "abc@example.com", password: "11111111")
      request.headers['Authorization'] = JsonWebToken.encode({doctor_id: doctor.id})
      get :index
    end
  end

  describe "SHOW all records" do
    it "actually" do
      doctor = Doctor.create(email: "abc@example.com", password: "11111111")
      patient = Patient.create(email: "abc@example.com", password: "11111111", name: "aa", birthdate: Date.new(10, 10, 10), height: 1322, weight: 132, sex: "male")
      request.headers['Authorization'] = JsonWebToken.encode({doctor_id: doctor.id})
      get :show, params: { id: patient.id }
    end
  end

end
