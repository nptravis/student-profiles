class Course < ActiveRecord::Base
	has_many :grades
	has_many :students, through: :grades
	has_many :standards, through: :grades

	def full_name
		self.course_name + " - " + self.course_number
	end

end