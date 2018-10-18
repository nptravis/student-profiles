class CoursesController < ApplicationController
	before_action :authentication_required
	
	def index
		if current_user.admin
			@courses = Course.all_courses
		else
			teacher = Teacher.find_by(email: current_user.email)
			@sections = Section.where('teacher_id = ?', teacher.id)
		end

		render json: @courses.to_json
	end

	def show
		@course = Course.find(params[:id])
		@students = @course.students.uniq
		respond_to do |format| 
			format.html
			format.json {render json: @course, serializer: CourseSerializer}
		end
	end

end
