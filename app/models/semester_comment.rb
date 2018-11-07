class SemesterComment < ApplicationRecord
	belongs_to :student
	belongs_to :section
	belongs_to :teacher

	validates :student_id, :teacher_id, :section_id, :semester, presence: true

end
