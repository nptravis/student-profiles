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
		current_grades = @student.grades.where("termid >= ?", 2800)
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

	def sections
		@student = Student.find(params[:id])
		@sections = @student.sections
		render partial: 'sections_index'
	end

	def section
		student = Student.find(params[:id])
		section = Section.find(params[:section_id])
		grades = student.grades.where("section_id = ?", section)
		semester_comments = student.semester_comments.where("section_id = ?", section.id)
		
		grades_hash = {
			:course_name => section.course_name,
			:course_number => section.course_number,
			:section_number => section.section_number,
			:expression => section.expression,
			:teacher => {lastfirst: section.teacher.lastfirst, email: section.teacher.email},
			:s1_standards => [],
			:s2_standards => [],
			:s1_homs => [],
			:s2_homs => [],
			:semester_comments => []
		}

		semester_comments.each do |comment|
			grades_hash[:semester_comments] << {semester: comment.semester, content: comment.content}
		end

		grades.each do |grade|
			if grade.standard.hom? && grade.semester == "S1"
				grades_hash[:s1_homs] << {:name => grade.standard.standard_name, :grade => grade.grade}
			elsif !grade.standard.hom? && grade.semester == "S1"
				grades_hash[:s1_standards] << {:name => grade.standard.identifier, :grade => grade.grade}
			elsif grade.standard.hom? && grade.semester == "S2"
				grades_hash[:s2_homs] << {:name => grade.standard.standard_name, :grade => grade.grade}
			elsif !grade.standard.hom? && grade.semester == "S2"
				grades_hash[:s2_standards] << {:name => grade.standard.identifier, :grade => grade.grade}
			else
				puts "ERROR: some grade didn't have a semester...."
			end
		end
		grades_hash[:s1_standards].sort_by!{|x| x[:name]}
		grades_hash[:s2_standards].sort_by!{|x| x[:name]}
		grades_hash[:s1_homs].sort_by!{|x| x[:name]}
		grades_hash[:s2_homs].sort_by!{|x| x[:name]}

		render json: grades_hash.to_json
	end

# BEGIN Private /////////////////////////////////////////////////////////////////////
	private


	def student_params
   	params.require(:student).permit(:search, :lastfirst, :student_number, :gradelevel)
  end
end
