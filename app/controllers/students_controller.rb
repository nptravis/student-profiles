class StudentsController < ApplicationController
	
	def index
		if logged_in?
			@current_user = current_user
			if params[:student]
	     @students = Student.search(student_params[:search]).sort_by &:lastfirst
	    else
	     @students = Student.all.sort_by &:lastfirst
	    end
	  else
	  	flash[:message] = "Must be logged in to do anything"
	  	redirect_to login_path
	  end
	end

	def show
		if logged_in?
			@current_user = current_user
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
		else
			flash[:message] = "Must be logged in to do anything"
			redirect_to login_path
		end
	end



	def student_params
   	params.require(:student).permit(:search)
  end
end
