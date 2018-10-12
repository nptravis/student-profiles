class StudentScheduleSerializer < ApplicationSerializer
  attributes :id, :show, :current_sections

  	def show
		StudentsController.render(:_schedule_matrix, assigns: {student: object}, layout: false).squish
	end

	def current_sections
		sections = []
		object.sections_current.each do |section|
			sections << {course_number: section.course.course_number, course_name: section.course.course_name, termid: section.term.term_code, section_number: section.section_number, teacher: section.teacher.lastfirst, expression: section.expression, room: section.room}
		end
		sections
	end



end
