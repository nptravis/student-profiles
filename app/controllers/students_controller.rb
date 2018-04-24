class StudentsController < ApplicationController
	def index
		if params[:student]
     @students = Student.search(student_params[:search])
    else
     @students = Student.all.sort_by &:lastfirst
    end
	end

	def show
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

	def student_params
   	params.require(:student).permit(:search)
  end
end
