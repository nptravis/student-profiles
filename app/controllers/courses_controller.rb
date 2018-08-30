class CoursesController < ApplicationController
	before_action :authentication_required
	
	def index
		if current_user.admin
			@courses = Course.all_courses
		else
			@courses = Course.where('teacher_email = ?', current_user.email)
		end

		render json: @courses.to_json
		# respond_to do |format|
		# 	format.json {render json: @courses}
		# 	format.html
		# end
	end

	def show
		@course = Course.find(params[:id])
		@students = @course.students
		@grades = @students.grades
		render json: @course
	end

end
