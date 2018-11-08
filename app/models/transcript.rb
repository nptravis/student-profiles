class Transcript < ApplicationRecord
	belongs_to :student

	validates :student_id, presence: true

	def calculate_year(sem1_gpa, sem2_gpa)
		if sem1_gpa && sem2_gpa
			((sem1_gpa + sem2_gpa) / 2).round(2)
		else
			""
		end
	end
end
