class StudentsController < ApplicationController
	before_action :authentication_required, :admin_auth_required

	def index
		if params[:student]
	     @students = Student.search(student_params[:search]).sort_by &:lastfirst
	    else
	     @students = Student.all.sort_by &:lastfirst
	    end
	end

	def show
		@comment = Comment.new
		@student = Student.find(params[:id])
		@data_hash = [
			{studentname: @student.lastfirst},
		]

		@student.courses.uniq.each do |course|
			course_hash = {
				course_name: course.course_name
			}
			course_hash[:s1_standards] = @student.standards_per_course_per_semester(course, "S1")
			course_hash[:s2_standards] = @student.standards_per_course_per_semester(course, "S2")
			course_hash[:s1_homs] = @student.homs_per_course_per_semester(course, "S1")
			course_hash[:s2_homs] = @student.homs_per_course_per_semester(course, "S2")
			@data_hash << course_hash
		end
	end

	def create
		@student = Student.create(student_params)
		redirect_to student_path(@student)
	end

	def new
		@student = Student.new
	end



	def student_params
   	params.require(:student).permit(:search, :lastfirst, :student_number, :gradelevel)
  end
end
