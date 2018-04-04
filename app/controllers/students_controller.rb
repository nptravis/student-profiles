class StudentsController < ApplicationController
	def index
		@students1 = Student.all
		@students = Student.all.sort_by {|student| student.lastfirst}
	end

	def show
		@student = Student.find(params[:id])
		@data_hash = {}
		@hom_array = [0, 0, 0, 0]
		@student.grades.each do |grade|
			if grade.percent
				case grade.standard.standardname
				when "Responsibility"
					@hom_array[0] = grade.percent.round
				when "Engagement"
					@hom_array[1] = grade.percent.round
				when "Reflection"
					@hom_array[2] = grade.percent.round
				when "Respect"
					@hom_array[3] = grade.percent.round
				else
					@data_hash.merge!(grade.standard.standardname => grade.percent.to_s)
				end
			end
		end
	end


end
