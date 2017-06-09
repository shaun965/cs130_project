require 'rails_helper'

RSpec.describe BloodPressure, :type => :model do

  before(:all) do
    Patient.create(email: "b@example.com", password: "11111111", name: "a", birthdate: Date.new(2010, 8, 27), height: 132, weight: 132, sex: "male")
  end

  it "is valid with valid attributes" do
  	expect(BloodPressure.new(high: 132, low: 132, patient_id: Patient.first.id)).to be_valid
  end

  it "is not valid without a high number" do
  	blood_pressure = BloodPressure.new(high: nil,low: 132, patient_id: Patient.first.id)
  	expect(blood_pressure).to_not be_valid
  end

  it "is not valid without a low number" do
    blood_pressure = BloodPressure.new(high: 132,low: nil, patient_id: Patient.first.id)
    expect(blood_pressure).to_not be_valid
  end

  describe "Associations" do
    it "belongs to one patient" do
      assc = described_class.reflect_on_association(:patient)
      expect(assc.macro).to eq :belongs_to
    end
  end

end