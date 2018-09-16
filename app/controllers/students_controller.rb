class StudentsController < ApplicationController
	before_action :authentication_required, :admin_auth_required, only: [:index]

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
		respond_to do |format|
			format.html {render partial: 'schedule_matrix'}
			format.json {render json: @student.to_json(methods: :sections_current)}
		end
	end 

	def map
		@student = Student.find(params[:id])
		render partial: 'map'
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
		student = Student.find(params[:id])
		section = Section.find(params[:section_id])
		s1_comment = SemesterComment.find_by(section_id: section.id, student_id: student.id, semester: "S1")
		s2_comment = SemesterComment.find_by(section_id: section.id, student_id: student.id, semester: "S2")
		if s1_comment
			s1_comment = s1_comment.content
		end
		if s2_comment
			s2_comment = s2_comment.content
		end
		collection_service = CollectionService.new
		
		section_data = {
			section_number: section.section_number,
			course_name: section.course.course_name,
			course_number: section.course.course_number,
			teacher_name: section.teacher.lastfirst,
			teacher_email: section.teacher.email,
			room: section.room,
			comments: [s1_comment, s2_comment]
		}

		data_sets = {
			s1: collection_service.grades_per_section_per_semester_per_student(section, "S1", student),
			s2: collection_service.grades_per_section_per_semester_per_student(section, "S2", student)
		}

		data_hash = [section_data, data_sets]
		
		render partial: 'section_show', locals: {data_hash: data_hash.to_json}
		
	end

# BEGIN Private /////////////////////////////////////////////////////////////////////
	private


	def student_params
   	params.require(:student).permit(:search, :lastfirst, :student_number, :gradelevel)
  end
end
