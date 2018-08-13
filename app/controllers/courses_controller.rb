class CoursesController < ApplicationController
	
	def index
		@courses = Course.all_courses
	end

end