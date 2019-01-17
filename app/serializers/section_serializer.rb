class SectionSerializer < ApplicationSerializer
  attributes :id, :section_number, :course_name, :course_number, :teacher_name, :matrix_positions, :expression, :grade_level, :department

  def course_name
  	object.course.course_name
  end

  def course_number
  	object.course.course_number
  end

  def teacher_name
  	object.teacher.lastfirst
  end

  def matrix_positions
  	object.matrix_positions
  end

  def department
    object.course.department
  end

end
