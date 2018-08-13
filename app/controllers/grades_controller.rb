class GradesController < ApplicationController
	def new
		@student = Student.find(params["student_id"])
		@standards = Standard.all.sort_by &:standardname
		@courses = Course.all.sort_by &:course_name
		@grade = Grade.new
	end

	def create
		@grade = Grade.create(grade_params)
		binding.pry
		@student = Student.find(params[:student_id])
		@grade.student_id = @student.id
		@grade.save
		@course = Course.find(params[:grade][:course_id])
		@student.grades << @grade
		
		redirect_to student_path(@student)
	end

	def grade_params
		params.require(:grade).permit(:course_id, :standard_id, :grade, :student_id, :semester)
	end

end 