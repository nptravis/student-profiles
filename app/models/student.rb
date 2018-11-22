class Student < ActiveRecord::Base
	belongs_to :school
	has_one :transcript
	has_many :attendances
	has_many :comments
	has_many :users, through: :comments
	has_many :student_sections
	has_many :sections, through: :student_sections
	has_many :grades
	has_many :trad_grades
	has_many :teachers, through: :sections
	has_many :courses, through: :sections
	has_many :standards, through: :grades
	has_many :semester_comments
	has_many :quarter_comments
	validates :lastfirst, :student_number, :grade_level, :ps_id, :dcid, presence: true
	validates_uniqueness_of :student_number

	def self.search(word)
	  	if word.present?
	  		self.where('lower(lastfirst) LIKE ?', "%#{word.downcase}%")
	  	else
	  		self.all
	  	end
	end

	def sections_per_term(term_code)
		self.sections.select{|section| section.term.term_code == term_code}
	end

	def sections_per_semester(term_code)
		collection = []
		if term_code.digits.first == 1
			collection << self.sections_per_term(term_code)
			collection << self.sections_per_term(term_code-1)
		elsif term_code.digits.first == 2
			collection << self.sections_per_term(term_code)
			collection << self.sections_per_term(term_code-2)
		end
		collection.flatten.sort { |a, b|  a.course.course_name <=> b.course.course_name }
	end

	def grades_per_term(termid)
		self.grades.select{|grade| grade.term.term_code == termid}
	end

	def homs_per_term(termid)
		temp_hash = {}
		grades = self.grades_per_term(termid)
		if grades
			grades.each do |grade|
				if grade.standard.hom?
					temp_hash[grade.standard.standard_name] = grade.grade
				end
			end
		end
		temp_hash.sort.to_h
	end

	def standards_per_term(termid)
		temp_hash = {}
		grades = self.grades_per_term(termid)
		if grades
			grades.each do |grade|
				if !grade.standard.hom?
					temp_hash[grade.standard.standard_name] = grade.grade
				end
			end
		end
		temp_hash.sort.to_h
	end

	def sections_current
		self.sections.select{|section| section.term.term_code != 2802}
	end

	def homeroom
		self.sections_current.select {|section|
			section.course.course_name.start_with?("Advisory")
		}[0]
	end

	def es_homeroom
		self.sections_current.select {|section|
			section.course.course_name.start_with?("Homeroom")
		}[0]
	end

	def homeroom_quarter_comment
		self.homeroom.quarter_comments.select{|comment| comment.student_id == self.id}[0].content
	end

	def grades_per_section(section)
		self.grades.where("section_id = ?", section.id)
	end

	def trad_grade_per_section(section)
		sec = self.trad_grades.where("section_id = ?", section.id)[0]
		if sec 
			sec.grade
		else
			"null"
		end
	end

	def homs_per_section(section)
		self.standards.where("section_id = ?", section.id).select{ |standard| standard.hom? }
	end

	def hs_reporting_sections(term_code)
		rejected_courses = ["ZHOM9", "ZHOM10", "ZHOM11", "ZHOM12", "MISC17", "MISC37", "RIS102", "RIS100", "RIS103", "RIS104", "RIS105", "RIS106", "RIS107", "RIS108", "ELEC325", "ZAD9", "ZAD10", "ZAD11", "ZAD12", "MISC200", "RIS101", "MISC15", "MISC36", "MIS001", "PE300", "PE401", "PE402", "ELEC749", "MISC100", "MAT106", "MAT104", "MAT105", "THA100", "THA220", "THA224", "THA359", "THA200", "THA222", "THA444", "MISC18", "MISC35", "REVA406", "MISC14"]

		self.sections_per_semester(term_code).reject{|section| rejected_courses.include?(section.course.course_number)}
	end

	def hs_summer_school(term_code)
		self.sections_per_semester(term_code).select{|section| section.section_number === "SS"}
	end

	def es_attendance
		self.attendances.find_by(section_id: self.es_homeroom.id)
	end

	def es_reporting_sections(term_code)
		rejected_courses = ["Library", "Homeroom"]
		self.sections_per_semester(term_code).reject{|section| section.course.course_name.starts_with?(*rejected_courses)}
	end

	def ms_reporting_sections(term_code)
		rejected_courses = ["MSFB", "HRA", "ADC1", "ADC2"]
		self.sections_per_semester(term_code).reject{|section| section.course.course_number.starts_with?(*rejected_courses)}
	end

	def es_homeroom_semester_comment
		self.es_homeroom.semester_comments.find_by(student_id: self.id)
	end

	def ms_homeroom_semester_comment
		self.homeroom.semester_comments.find_by(student_id: self.id)
	end

	def self.ms_students
		where("school_id = ?", School.ms.id)
	end

	def self.es_students
		where("school_id = ?", School.es.id)
	end

	def self.hs_students
		where("school_id = ?", School.hs.id)
	end

end