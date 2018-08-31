class CourseStandard < ActiveRecord::Base
	belongs_to :standard
	belongs_to :course
	validates :standard_id, :course_id, presence: true

end
