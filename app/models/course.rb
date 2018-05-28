class Course < ActiveRecord::Base
	belongs_to :user
	has_many :grades
	has_many :students, through: :grades
	has_many :standards, through: :grades
	validates :course_name, :course_number, presence: true

	def full_name
		self.course_name + " - " + self.course_number
	end

end
