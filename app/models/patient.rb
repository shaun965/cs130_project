class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name, :birthdate, :height, :weight

  has_and_belongs_to_many :doctors
  has_many :dr_scores
  has_many :blood_sugars
  has_many :blood_pressures
  has_many :blood_fat
  
end
