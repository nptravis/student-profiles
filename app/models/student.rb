class Student < ActiveRecord::Base
	belongs_to :school
	has_one :transcript
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
	validates :lastfirst, :student_number, :grade_level, :dcid, presence: true
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


end