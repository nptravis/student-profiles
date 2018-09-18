class CourseSerializer < ApplicationSerializer
  attributes :course_name, :course_number
  has_many :standards

end
