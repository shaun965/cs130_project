class BloodPressure < ApplicationRecord
	belongs_to :patient
	validates_presence_of :high, :low

end
