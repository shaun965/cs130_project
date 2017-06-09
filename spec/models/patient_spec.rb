require 'rails_helper'

RSpec.describe Patient, :type => :model do

  it "is valid with valid attributes" do
  	expect(Patient.new(email: "c@example.com", password: "11111111", name: "a", birthdate: Date.new(2010, 8, 27), height: 132, weight: 132, sex: "male")).to be_valid
  end

  it "is not valid without a title" do
  	patient = Patient.new(email: nil, password: "11111111")
  	expect(patient).to_not be_valid
  end

  it "is not valid without a password" do
  	patient = Patient.new(email: "c@example.com", password: nil)
  	expect(patient).to_not be_valid	
  end

  it "is not valid without a name" do
    expect(Patient.new(email: "c@example.com", password: "11111111", name: nil, birthdate: Date.new(2010, 8, 27), height: 132, weight: 132, sex: "male")).to_not be_valid
  end

  it "is not valid without a birthdate" do
    expect(Patient.new(email: "c@example.com", password: "11111111", name: "a", birthdate: nil, height: 132, weight: 132, sex: "male")).to_not be_valid
  end

  it "is not valid without a height" do
    expect(Patient.new(email: "c@example.com", password: "11111111", name: "a", birthdate: Date.new(2010, 8, 27), height: nil, weight: 132, sex: "male")).to_not be_valid
  end

  it "is not valid without a height" do
    expect(Patient.new(email: "c@example.com", password: "11111111", name: "a", birthdate: Date.new(2010, 8, 27), height: 143, weight: nil, sex: "male")).to_not be_valid
  end

  describe "Associations" do
    it "belongs to many doctors" do
      assc = described_class.reflect_on_association(:doctors)
      expect(assc.macro).to eq :has_and_belongs_to_many
    end

    it "has many doctors" do
      assc = described_class.reflect_on_association(:doctors)
      expect(assc.macro).to eq :has_and_belongs_to_many
    end

    it "has many blood sugars" do
      assc = described_class.reflect_on_association(:blood_sugars)
      expect(assc.macro).to eq :has_many
    end

    it "has many blood fat" do
      assc = described_class.reflect_on_association(:blood_fat)
      expect(assc.macro).to eq :has_many
    end

    it "has many blood pressures" do
      assc = described_class.reflect_on_association(:blood_pressures)
      expect(assc.macro).to eq :has_many
    end

    it "has many dr scores" do
      assc = described_class.reflect_on_association(:dr_scores)
      expect(assc.macro).to eq :has_many
    end
  end

end