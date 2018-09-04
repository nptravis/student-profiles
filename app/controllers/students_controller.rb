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

		if params[:section_id]
			@section = Section.find(params[:section_id])
			temp_array = []
			@section.grades.where('student_id = ?', @student.id).each do |grade|
				standard = grade.standard.standard_name
				temp_array << {standard => grade.grade}
			end
			render json: temp_array.to_json
		end

		@comment = Comment.new
		@data_hash = [
			{studentname: @student.lastfirst},
		]

		@student.courses.uniq.each do |course|
			course_hash = {
				course_name: course.course_name
			}
			course_hash[:s1_standards] = @student.standards_per_course_per_semester(course, "S1")
			course_hash[:s2_standards] = @student.standards_per_course_per_semester(course, "S2")
			course_hash[:s1_homs] = @student.homs_per_course_per_semester(course, "S1")
			course_hash[:s2_homs] = @student.homs_per_course_per_semester(course, "S2")
			@data_hash << course_hash
		end

		
	end

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
			format.html
			format.js {render json: @student.to_json(methods: :sections_current)}
		end
	end 



	def student_params
   	params.require(:student).permit(:search, :lastfirst, :student_number, :gradelevel)
  end
end
