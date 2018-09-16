class Course < ActiveRecord::Base
	has_many :sections
	has_many :course_terms
	has_many :terms, through: :course_terms
	has_many :students, through: :sections
	has_many :course_standards
	has_many :standards, through: :course_standards
	validates :course_name, :course_number, :dcid, presence: true

	def full_name
		self.course_name + " - " + self.course_number
	end

	def self.all_courses
		order(:course_name)
	end

	def self.courses_by_grade_level(grade)
		self.all.where
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

end
