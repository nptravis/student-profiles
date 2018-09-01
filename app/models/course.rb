class Course < ActiveRecord::Base
	has_many :sections
	has_many :students, through: :sections
	has_many :course_standards
	has_many :standards, through: :course_standards
	validates :course_name, :course_number, presence: true

	def full_name
		self.course_name + " - " + self.course_number
	end

	def self.all_courses
		order(:course_name)
	end

end
