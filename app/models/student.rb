class Student < ActiveRecord::Base
	has_many :comments
	has_many :users, through: :comments
	has_many :student_sections
	has_many :sections, through: :student_sections
	has_many :grades
	has_many :teachers, through: :sections
	has_many :courses, through: :sections
	has_many :standards, through: :grades
	validates :lastfirst, :student_number, :gradelevel, :dcid, presence: true
	validates_uniqueness_of :student_number

	def self.search(word)
	  	if word.present?
	  		self.all.where('lastfirst LIKE ?', "%#{word}%")
	  	else
	  		self.all
	  	end
	end

	def grades_per_section(section)
		self.grades.where("section_id = ?", section.id)
	end

	
	def grades_per_termid_per_section(termid, section)
		self.grades.where("termid = ? AND section_id = ?", termid, section.id);
	end

    def grades_per_course_per_termid(course, termid)
	  	section = self.sections.where("termid = ? AND course_id = ?", termid, course.id)[0] 
	  	if section
	  		section.grades.where("student_id = ?", self.id)
	  	end
	end

	def homs_per_course_per_termid(course, termid)
		temp_hash = {}
		grades = self.grades_per_course_per_termid(course, termid)
		if grades
			grades.each do |grade|
				if grade.standard.hom?
					temp_hash[grade.standard.standard_name] = grade.grade
				end
			end
		end
		temp_hash.sort.to_h
	end

	def standards_per_course_per_termid(course, termid)
		temp_hash = {}
		grades = self.grades_per_course_per_termid(course, termid)
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
		self.sections.where("termid >= ?", 2800);
	end

end