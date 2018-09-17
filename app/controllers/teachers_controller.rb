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

	def show
		@teacher = Teacher.find(params[:id])
		respond_to do |format|
			format.json {render json: @teacher, serializer: TeacherSerializer}
			format.html 
		end
	end

	def index
		@teachers = Teacher.all.order(:lastfirst)
	end

	def current_sections
		@teacher = Teacher.find(params[:id])
		render json: @teacher, serializer: TeacherSerializer
	end


end
