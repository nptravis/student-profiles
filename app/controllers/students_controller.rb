class StudentsController < ApplicationController
	def index
		@students1 = Student.all
		@students = Student.all.sort_by {|student| student.lastfirst}
	end

	def show
		@student = Student.find(params[:id])
		@data_array = []
		@student.grades.each do |grade|
			@data_array << {name: grade.standard.standardname, data: grade.percent.to_s}
		end
	end
end
