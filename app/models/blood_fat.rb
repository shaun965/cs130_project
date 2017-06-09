class BloodFat < ApplicationRecord
	belongs_to :patient
	validates_presence_of :number

end
