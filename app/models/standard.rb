class Standard < ActiveRecord::Base
	has_many :grades
	has_many :students, through: :grades
	has_many :course_standards
	has_many :courses, through: :course_standards
	has_many :sections, through: :courses
	validates :standard_name, :description, :identifier, :dcid, presence: true

	def hom?
		!!self.standard_name.match(/Respect$|Responsibility$|Engagement$|Reflection$/)
	end

	def self.standards_per_grade_per_term(grade, term)
		collection = []
		Section.sections_per_grade_per_term(grade,term).each do |section|
			section.standards.each do |standard|
				collection << standard
			end
		end
		collection.uniq
	end 

	def grades_per_term_per_grade_level(termId, grade_level)
		self.grades.where("term_id = ?", termId).select{|grade|
			grade.student.grade_level == grade_level}
	end

	def grade_hash
		grade_json = []
		self.grades.each do |grade|
			grade_json << {grade: grade.grade, term: grade.term.term_code, grade_level: grade.student.grade_level}
		end
		grade_json
	end

	def self.search(word)
	  	if word.present?
	  		self.where('lower(identifier) LIKE ?', "%#{word.downcase}%").or(self.where('lower(standard_name) LIKE ?', "%#{word.downcase}%"))
	  	else
	  		self.all
	  	end
	end

	def grade_per_student(student)
		grade = student.grades.where("standard_id = ?", self.id)[0]
		if grade.present?
			grade.grade
		else
			""
		end
	end

	def terms
		collection = []
		self.grades.each do |grade|
			 (collection.include?(grade.term) || collection << grade.term)
		end
		collection
	end

end

