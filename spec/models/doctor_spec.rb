require 'rails_helper'
require 'pry'

RSpec.describe Doctor, :type => :model do

  it "is valid with valid attributes" do
  	expect(Doctor.new(email: "a@example.com", password: "11111111")).to be_valid
  end

  it "is not valid without a title" do
  	doctor = Doctor.new(email: nil, password: "11111111")
  	expect(doctor).to_not be_valid
  end

  it "is not valid without a password" do
  	doctor = Doctor.new(email: "a@example.com", password: nil)
  	expect(doctor).to_not be_valid	
  end

  describe "Associations" do
    it "belongs to many patients" do
      assc = described_class.reflect_on_association(:patients)
      expect(assc.macro).to eq :has_and_belongs_to_many
    end

    it "has many patients" do
      assc = described_class.reflect_on_association(:patients)
      expect(assc.macro).to eq :has_and_belongs_to_many
    end
  end

end