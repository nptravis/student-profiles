class Section < ApplicationRecord
	belongs_to :course
	belongs_to :teacher
	has_many :student_sections
	has_many :students, through: :student_sections
	validates :course_id, :teacher_id, :course_number, :course_name, :section_number, :semester, presence: true
end
