class StudentsController < ApplicationController
	before_action :authentication_required

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
		@student.uniq_courses.each do |course|
			@data_hash << {
				course_name: course.full_name,
				s1_standards: @student.standards_per_semester_per_course("S1",course).sort.to_h,
				s2_standards: @student.standards_per_semester_per_course("S2",course).sort.to_h,
				s1_homs: @student.homs_per_semester_per_course("S1", course).sort.to_h,
				s2_homs: @student.homs_per_semester_per_course("S2", course).sort.to_h,
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
