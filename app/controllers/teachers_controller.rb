class TeachersController < ApplicationController

	def students 
		@teacher = Teacher.find(params[:id])
		@sections = Section.where("teacher_id = ?", @teacher.id)
		@students = []
		@sections.each do |section|
			@students += section.students
		end
		@students = @students.sort_by(&:lastfirst).uniq
	end


end
