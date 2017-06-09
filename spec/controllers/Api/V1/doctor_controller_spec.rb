require 'rails_helper'

RSpec.describe Api::V1::DoctorController, :type => :controller do
  describe "GET authenticate doctor" do

    it "authenticates valid doctor" do
      doctor = Doctor.create(email: "abc@example.com", password: "11111111")
      json = { :format => 'json', :params => { :email => "abc@example.com", :password => "11111111" } }
      post :authenticate_doctor, json
      expect(JSON.parse(response.body)["meta"]).to eq("Login Success")
    end

    it "doesn't authenticate invalid doctor email" do
      doctor = Doctor.create(email: "abc@example.com", password: "11111111")
      json = { :format => 'json', :params => { :email => "abd@example.com", :password => "11111111" } }
      post :authenticate_doctor, json
      expect(JSON.parse(response.body)["errors"]).to eq("Invalid Username/Password")
    end

    it "doesn't authenticate invalid doctor password" do
      doctor = Doctor.create(email: "abc@example.com", password: "22222222")
      json = { :format => 'json', :params => { :email => "abd@example.com", :password => "11111111" } }
      post :authenticate_doctor, json
      expect(JSON.parse(response.body)["errors"]).to eq("Invalid Username/Password")
    end

  end

  describe "POST sign up" do
  	it "signs up valid doctor" do
      json = { :format => 'json', :params => { :email => "abe@example.com", :password => "11111111" } }
      post :sign_up, json
      expect(JSON.parse(response.body)["meta"]).to eq("Sign up Success")
    end

    it "doesn't sign up doctors with bad password" do
      json = { :format => 'json', :params => { :email => "abf@example.com", :password => nil } }
      post :sign_up, json
      expect(JSON.parse(response.body)["meta"]).to eq("Sign up Failed")
	end
  end

end
