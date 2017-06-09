require 'rails_helper'

RSpec.describe Api::V1::PatientController, :type => :controller do
  describe "GET authenticate patient" do

    it "authenticates valid patient" do
      patient = Patient.create(email: "abc@example.com", password: "11111111", name: "aa", birthdate: Date.new(10, 10, 10), height: 1322, weight: 132, sex: "male")
      json = { :format => 'json', :params => { :email => "abc@example.com", :password => "11111111" } }
      post :authenticate_patient, json
      expect(JSON.parse(response.body)["meta"]).to eq("Login Success")
    end

    it "doesn't authenticate invalid patient email" do
      patient = Patient.create(email: "abc@example.com", password: "11111111", name: "aa", birthdate: Date.new(10, 10, 10), height: 1322, weight: 132, sex: "male" )
      json = { :format => 'json', :params => { :email => "abd@example.com", :password => "11111111" } }
      post :authenticate_patient, json
      expect(JSON.parse(response.body)["errors"]).to eq("Invalid Username/Password")
    end

    it "doesn't authenticate invalid patient password" do
      patient = Patient.create(email: "abc@example.com", password: "22222222", name: "aa", birthdate: Date.new(10, 10, 10), height: 1322, weight: 132, sex: "male" )
      json = { :format => 'json', :params => { :email => "abd@example.com", :password => "11111111" } }
      post :authenticate_patient, json
      expect(JSON.parse(response.body)["errors"]).to eq("Invalid Username/Password")
    end

  end

  describe "POST sign up" do
  	it "signs up valid patient" do
      doctor = Doctor.create(email: "abc@example.com", password: "11111111")
      json = { :format => 'json', :params => { :email => "abe@example.com", :password => "11111111", name: "aa", birthdate: Date.new(10, 10, 10), height: 1322, weight: 132, sex: "male" } }
      request.headers['Authorization'] = JsonWebToken.encode({doctor_id: doctor.id})
      post :sign_up, json
      expect(JSON.parse(response.body)["meta"]).to eq("Sign up Success")
    end

    it "doesn't sign up patients with bad password" do
      doctor = Doctor.create(email: "abc@example.com", password: "11111111")
      json = { :format => 'json', :params => { :email => "abf@example.com", :password => nil, name: "aa", birthdate: Date.new(10, 10, 10), height: 1322, weight: 132, sex: "male" } }
      request.headers['Authorization'] = JsonWebToken.encode({doctor_id: doctor.id})      
      post :sign_up, json
      expect(JSON.parse(response.body)["meta"]).to eq("Sign up Failed")
	  end

  end

end
