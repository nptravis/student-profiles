class Attendance < ApplicationRecord
	belongs_to :student
	belongs_to :section

	validates :absences, :tardies, :student_id, presence: true
end
