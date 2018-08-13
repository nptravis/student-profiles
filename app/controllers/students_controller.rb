class StudentsController < ApplicationController
	before_action :authentication_required, only: [:index, :show]

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
		@s1_data_hash = [
			{studentname: @student.lastfirst},
		]
		@student.uniq_courses.each do |course|
			@s1_data_hash << {
				course_name: course.full_name,
				standards: @student.standards_per_course(course).sort.to_h,
				homs: @student.homs_per_course(course).sort.to_h
			}
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
