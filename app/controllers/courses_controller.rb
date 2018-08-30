class CoursesController < ApplicationController
	before_action :authentication_required
	
	def index
		if current_user.admin
			@courses = Course.all_courses
		else
			@courses = Course.where('teacher_email = ?', current_user.email)
		end
	end

end