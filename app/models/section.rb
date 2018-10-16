class Section < ApplicationRecord
	belongs_to :course
	belongs_to :teacher
	belongs_to :term
	has_many :grades
	has_many :student_sections
	has_many :students, through: :student_sections
	has_many :semester_comments
	has_many :quarter_comments
	has_many :standards, through: :course
	validates :course_id, :teacher_id, :room, :section_number, :grade_level, :dcid, :term_id, :expression, presence: true

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
		self.all.where("grade_level = ? AND term_id = ?", grade, grade.term.id)
	end

	def all_standards
		collection = []
		self.standards.each do |standard|
			if !standard.hom?
				collection << standard
			end
		end
		collection
	end

	def all_homs_by_student(student)
		collection = []
		self.grades.where("student_id = ?", student).each do |grade|
			if grade.standard.hom?
				collection << grade
			end
		end
		collection
	end

	def all_standards_by_student(student)
		collection = []
		self.grades.where("student_id = ?", student).each do |grade|
			if !grade.standard.hom?
				collection << grade
			end
		end
		collection
	end

	def grades_per_semester_per_student(semester, student)
		standards = {}
		homs = {}
		collection = [standards, homs]
		self.grades.where("student_id = ? and semester = ?", student.id, semester).each do |grade|
			if !grade.standard.hom?
				standards["#{grade.standard.standard_name}"] = grade.grade
				
			else
				homs["#{grade.standard.standard_name}"] = grade.grade
			end
		end
		collection = {standards: standards.sort.to_h, homs: homs.sort.to_h}
		collection
	end

	def comments_per_student(student)
		collection = []
		SemesterComment.where("section_id = ? AND student_id = ?", self.id, student.id).each do |comment|
			collection << {semester: comment.semester, content: comment.content}
		end
		collection
	end

	def core?
		self.course.course_number.start_with?(
			"LA", "SCI", "MA", "SOC", "ADC"
			)
	end

	def required?
		self.course.course_number.start_with?(
			"PE", "THA", "VAL", "HE", "SNSK", "ESL"
			)
	end

	def quarter_comment_per_student(student)
		self.quarter_comments.select{|comment| comment.student_id == student.id}[0].content
	end

end
