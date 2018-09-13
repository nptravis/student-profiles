class Section < ApplicationRecord
	belongs_to :course
	belongs_to :teacher
	has_many :grades
	has_many :student_sections
	has_many :students, through: :student_sections
	has_many :semester_comments
	has_many :standards, through: :course
	validates :course_id, :teacher_id, :course_number, :course_name, :room, :section_number, :dcid, :termid, :expression, presence: true

	def grades_per_student(student)
		self.grades.where("student_id = ?", student)
	end

	def percentage_of_grades_per_student(student, grade)
		grades = self.grades_per_student(student)
		grade_total = grades.where("grade = ?", grade).count.to_f
		if grades.count > 0
			percentage = (grade_total / grades.count.to_f)*100
			percentage.round
		else
			percetage = 0
		end
		percentage
	end

	def self.sections_per_grade_per_term(grade, term)
		self.all.where("grade_level = ? AND termid = ?", grade, term)
	end

end
