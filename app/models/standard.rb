class Standard < ActiveRecord::Base
	has_many :grades
	has_many :standard_terms
	has_many :terms, through: :standard_terms
	has_many :students, through: :grades
	has_many :course_standards
	has_many :courses, through: :course_standards
	has_many :sections, through: :courses
	validates :standard_name, :identifier, :dcid, presence: true

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

end

