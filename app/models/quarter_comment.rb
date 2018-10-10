class QuarterComment < ApplicationRecord
	belongs_to :student
	belongs_to :teacher
	belongs_to :section

	validates :teacher_id, :student_id, :section_id, presence: true
end