class SectionsController < ApplicationController

	def index
		if current_user.admin
			@sections = Section.all
		else
			teacher = Teacher.find_by(email: current_user.email)
			@sections = Section.where('teacher_id = ?', teacher.id)
		end
		render json: @sections.to_json
	end

	def show
		@section = Section.find(params[:id])
		render json: @section.to_json
	end

	def students
		section = Section.find(params[:id])
		@students = section.students
		render json: @students.to_json
	end

end
