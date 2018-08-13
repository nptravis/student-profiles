class Grade < ActiveRecord::Base
	belongs_to :student
	belongs_to :standard
	belongs_to :course
	validates :standard_id, :student_id, :grade, :course_id, :semester, presence: true

end
