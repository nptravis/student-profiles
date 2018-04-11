class StudentsController < ApplicationController
	def index
		@students = Student.all.sort_by &:lastfirst
	end

	def show
		@student = Student.find(params[:id])
		@data_hash = {
			standard_names: [],
			standard_grades: [],
			hom_names: [],
			hom_grades: []
		}
		@student.grades.each do |grade|
			if grade.standard.standardname != "Semester Comment"
				case grade.grade
				when "E"
					name = grade.standard.standardname
					grade = 4
				when "M"
					name = grade.standard.standardname
					grade = 3
				when "P"
					name = grade.standard.standardname
					grade = 2
				when "B"
					name = grade.standard.standardname
					grade = 1
				else 
					name = grade.standard.standardname
					grade = 0
				end
				if name.match(/\bRespect\b|\bResponsibility\b|\bEngagement\b|\bReflection\b/)
					@data_hash[:hom_names].push(name) 
					@data_hash[:hom_grades].push(grade) 
				else 
					@data_hash[:standard_names].push(name)
					@data_hash[:standard_grades].push(grade)
				end
			end
		end
		
	end


end
