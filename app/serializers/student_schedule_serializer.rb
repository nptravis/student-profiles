class StudentScheduleSerializer < ApplicationSerializer
  attributes :id, :show, :current_sections

  	def show
		StudentsController.render(:_schedule_matrix, assigns: {student: object}, layout: false).squish
	end

	def current_sections
		object.sections_current
	end
end
