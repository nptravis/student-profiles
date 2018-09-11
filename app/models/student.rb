class Student < ActiveRecord::Base
	has_many :comments
	has_many :users, through: :comments
	has_many :student_sections
	has_many :sections, through: :student_sections
	has_many :grades
	has_many :teachers, through: :sections
	has_many :courses, through: :sections
	has_many :standards, through: :grades
	has_many :semester_comments
	validates :lastfirst, :student_number, :gradelevel, :dcid, presence: true
	validates_uniqueness_of :student_number

	def self.search(word)
	  	if word.present?
	  		self.all.where('lastfirst LIKE ?', "%#{word}%")
	  	else
	  		self.all
	  	end
	end

	def sections_per_term(termid)
		self.sections.where("termid = ?", termid);
	end

	def grades_per_term(termid)
		self.grades.where("termid = ?", termid)
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
		self.sections.where("termid >= ?", 2800);
	end

end