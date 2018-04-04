class StudentsController < ApplicationController
	def index
		@students = Student.all.sort_by {|student| student.lastfirst}
	end

	def show
		@student = Student.find(params[:id])
	end
end
