class StudentsController < ApplicationController
	before_action :authentication_required, :admin_auth_required, only: [:index]

	def index
		if params[:student]
	     @students = Student.search(student_params[:search]).sort_by &:lastfirst
	    else
	     @students = Student.all.sort_by &:lastfirst
	    end
	end

	def show
		@student = Student.find(params[:id])
	end

	# def section_data
	# 	@student = Student.find(params[:id])
	# 	@section = Section.find(params[:section_id])
	# 	# @data_hash = [
	# 	# 	{studentname: @student.lastfirst},
	# 	# ]

	# 	# @student.sections.each do |section|
	# 	# 	section_hash = {
	# 	# 		course_name: section.course_name
	# 	# 	}
	# 	# 	section_hash[:s2701_standards] = @student.standards_per_term(2701)
	# 	# 	section_hash[:s2702_standards] = @student.standards_per_term(2702)
	# 	# 	section_hash[:s2801_standards] = @student.standards_per_term(2801)
	# 	# 	section_hash[:s2701_homs] = @student.homs_per_term(2701)
	# 	# 	section_hash[:s2702_homs] = @student.homs_per_term(2702)
	# 	# 	section_hash[:s2801_homs] = @student.homs_per_term(2801)
	# 	# 	@data_hash << section_hash
	# 	# end
	# 	respond_to do |format|
	# 		format.html
	# 		format.js {render json: @section.to_json(include: :grades)}
	# 	end
	# end

	def create
		@student = Student.create(student_params)
		redirect_to student_path(@student)
	end

	def new
		@student = Student.new
	end

	def schedule
		@student = Student.find(params[:id])
		respond_to do |format|
			format.html {render partial: 'schedule_matrix'}
			format.js {render json: @student.to_json(methods: :sections_current)}
		end
	end 

	def map
		@student = Student.find(params[:id])
		render partial: 'map'
	end

	def bell_schedule
		@student = Student.find(params[:id])
	end


	def student_params
   	params.require(:student).permit(:search, :lastfirst, :student_number, :gradelevel)
  end
end
