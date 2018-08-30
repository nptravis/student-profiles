class CoursesController < ApplicationController
	before_action :authentication_required
	before_action :admin_auth_required, only: [:index]
	
	def index
		@courses = Course.all_courses
	end

	def teacher_index
		@courses = Course.all.where('teacher LIKE ?', "%#{current_user.username}%")
	end

end

self.all.where('lastfirst LIKE ?', "%#{word}%")