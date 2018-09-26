class StudentsController < ApplicationController
	before_action :authentication_required

# BEGIN Rest ///////////////////////////////////////////////////////////////////
	def index
		if params[:student]
	     @students = Student.search(student_params[:search]).sort_by &:lastfirst
	    else
	     @students = Student.all.sort_by &:lastfirst
	    end
	end

	def show
		collection = CollectionService.new
		@student = Student.find(params[:id])
		term = Term.find_by(term_code: 2800);
		current_grades = @student.grades.where("term_id = ?", term.id)
		@all_standards = collection.all_standards(current_grades)
		@all_homs = collection.all_homs(current_grades)
	end

	def create
		@student = Student.create(student_params)
		redirect_to student_path(@student)
	end

	def new
		@student = Student.new
	end
# END Rest /////////////////////////////////////////////////////////////////////////

	def schedule
		@student = Student.find(params[:id])
		render json: @student, serializer: StudentScheduleSerializer
	end 

	def map
		@student = Student.find(params[:id])
		render json: @student.to_json
	end

	def bell_schedule
		@student = Student.find(params[:id])
	end

	def sections
		@student = Student.find(params[:id])
		@sections = @student.sections
		render partial: 'sections_index'
	end

	def section
		@student = Student.find(params[:id])
		@section = Section.find(params[:section_id])
		render partial: 'section_show'
	end

# BEGIN Private /////////////////////////////////////////////////////////////////////
	private


	def student_params
   	params.require(:student).permit(:search, :lastfirst, :student_number, :gradelevel)
  end
end
