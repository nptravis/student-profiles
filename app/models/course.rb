class Course < ActiveRecord::Base
	has_many :grades
	has_many :students, through: :grades
	has_many :standards, through: :grades
	validates :course_name, :course_number, :section, :teacher_email, presence: true

	def full_name
		self.course_name + " - " + self.course_number
	end

	def self.all_courses
		order(:course_name)
	end

end
