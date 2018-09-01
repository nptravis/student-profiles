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
		@student.sections.each do |section|
			@data_hash << {
				course_name: section.course_name,
				s1_standards: @student.standards_per_semester_per_section("S1",section).sort.to_h,
				s2_standards: @student.standards_per_semester_per_section("S2",section).sort.to_h,
				s1_homs: @student.homs_per_semester_per_section("S1", section).sort.to_h,
				s2_homs: @student.homs_per_semester_per_section("S2", section).sort.to_h,
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
