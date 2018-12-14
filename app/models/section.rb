class Section < ApplicationRecord
	belongs_to :course
	belongs_to :teacher
	belongs_to :term
	has_many :attendances
	has_many :grades
	has_many :trad_grades
	has_many :student_sections
	has_many :students, through: :student_sections
	has_many :semester_comments
	has_many :quarter_comments
	has_many :standards, through: :course
	validates :course_id, :room, :teacher_id, :section_number, :grade_level, :dcid, :term_id, :expression, presence: true

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
			"LA", "SCI", "MA", "SOC", "ADCLA", "ADCSOC", "ADCMAT", "ADCSCI"
			)
	end

	def hs_core?
		self.course.course_number.start_with?(
			"LA", "SCI", "MA", "SOC", "ADC"
			)
	end

	def es_core?
		core_course_names = ["Science", "Reading", "Writing", "Language Foundations", "Math ", "Social Studies"]
		self.course.course_name.start_with?(*core_course_names)
	end

	def required?
		self.course.course_number.start_with?(
			"PE", "THA", "VAL", "HE", "SNSK", "ESL", "ADCTHAI"
			)
	end

	def quarter_comment_per_student(student)
		self.quarter_comments.select{|comment| comment.student_id == student.id}[0].content
	end

	def semester_comment_per_student(student)
		self.semester_comments.find_by(student_id: student.id)
	end

	def semester
		case self.term.term_code
		when 2800
			"18-19"
		when 2801
			"S1"
		when 2802
			"S2"
		end
	end

	def es_reporting_standards
		rejected_standards = ["Comment", "Language Foundations", 
			"Math", "Art", "Music", "Physical Education", "Science", 
			"Values/Religion", "Thai Language & Culture", "Social Studies", "Exploring", 
			"Writing 5", 
			"Reading 5",
			"Writing 4", 
			"Reading 4",
			"Writing 3", 
			"Reading 3",
			"Writing 2", 
			"Reading 2",
			"Writing 1", 
			"Reading 1",
			"Writing K", 
			"Reading K"
		]
		self.standards.reject{|standard| standard.standard_name.start_with?(*rejected_standards)}
	end
	
	def es_semester_comment_per_student(student)
		self.semester_comments.find_by(student_id: student.id)
	end

	def self.by_school(school)
		includes(:course).select{|section| section.course.school === school}
	end

	def matrix_positions
		collection = []
		number_of_periods = 7
		rows = ["A", "B", "C", "D"]
		exp_arr = self.expression.split(" ")
		
		exp_arr.each do |x|
			period = x.match(/\d/)[0].to_i - 1
			days = x.match(/[(](.+)[)]/)[1]
			if days.length === 1
				collection << period + rows.index(days)*number_of_periods
			else
				days_arr = days.split("")
				if days_arr.include?("-") && days_arr.include?(",")
					collection << period + rows.index(days[0])*number_of_periods
					collection << period + rows.index(days[2])*number_of_periods
					collection << period + rows.index(days[4])*number_of_periods
				elsif days_arr.include?("-")
					rows[rows.index(days_arr[0])..rows.index(days_arr[2])].each_with_index do |d, i|
						
						collection << period + i*number_of_periods
					end
				else
					collection << period + number_of_periods * rows.index(days_arr[0])
					collection << period + number_of_periods * rows.index(days_arr[2])
				end
			end	
		end
		collection
	end

	def in_matrix_position?(period_string, day_string)

		days = {
			A: 0,
			B: 7,
			C: 14,
			D: 21
			}

		periods = {
			ADV: 6,
			P1: 0,
			P2: 1,
			P3: 2,
			FB: 5,
			P4: 3,
			P5: 4 
		 }

		position = days[day_string.to_sym] + periods[period_string.to_sym]
		self.matrix_positions.include?(position)
	end

	def self.es_homerooms
		by_school(School.es).select{|section| section.course.course_name.start_with?("Homeroom")}.sort_by{|section| section.teacher.lastfirst}

		# 
	end

	def academic_standards?
		self.standards.select{|s| !s.hom? && s.standard_name != "Semester Comment" && s.description != "Parent Standard" }[0].present?
	end


end