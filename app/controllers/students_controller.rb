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
		term = Term.find_by(term_code: 2801);
		current_grades = @student.grades.where("term_id = ?", term.id)
		@all_standards = collection.all_standards(current_grades)
		@all_homs = collection.all_homs(current_grades)
		@sections = @student.sections
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

	def report_card_links
		@student = Student.find(params[:id])
		render json: @student, serializer: ReportCardLinksSerializer
	end

	def q1_reportcard
		@student = Student.find(params[:id])
		respond_to do |format|
	      format.html
	      format.pdf do
        	render pdf: "q1-reportcard-#{@student.student_number}", 
        	layout: 'pdf.html.erb',
        	template: 'students/q1_reportcard.html.erb',
        	window_status: "FLAG_FOR_PDF",
        	dpi: '300'
        end
      end
	end

	def sem1_reportcard
		@student = Student.find(params[:id])
		
		if @student.school.number === 102
			@sections = @student.ms_reporting_sections(2801)
			respond_to do |format|
		      format.pdf do
	        	render pdf: "sem1-reportcard-#{@student.student_number}", 
	        	layout: 'sem1_report_card.html.erb',
	        	template: 'students/sem1_reportcard.html.erb',
	        	orientation: 'Landscape',
	        	page_size: 'A3',
	        	window_status: "FLAG_FOR_PDF",
	        	dpi: '300',
	        	show_as_html: params.key?('debug'),
	        	margin:  { 
	        		top:               10,                     
	                bottom:            0,
	                left:              5,
	                right:             5}
	        end
	      end
	    elsif @student.school.number === 101
	    	@sections = @student.hs_reporting_sections(2801)
	    	
	    	if @student.student_number === '16488'
	    		@sections << Section.find_by(dcid: 33855)
	    	end
	    	
	    	respond_to do |format|
		      format.pdf do
	        	render pdf: "sem1-reportcard-#{@student.student_number}", 
	        	layout: 'sem1_report_card.html.erb',
	        	template: 'students/hs_sem1_reportcard.html.erb',
	        	orientation: 'Landscape',
	        	page_size: 'A3',
	        	window_status: "FLAG_FOR_PDF",
	        	dpi: '300',
	        	show_as_html: params.key?('debug'),
	        	margin:  { 
	        		top:               10,                     
	                bottom:            5,
	                left:              5,
	                right:             5}
		      end
			end
		else
			@sections = @student.es_reporting_sections(2801)
			respond_to do |format|
		      format.pdf do
	        	render pdf: "sem1-reportcard-#{@student.student_number}", 
	        	layout: 'sem1_report_card.html.erb',
	        	template: 'students/es_sem1_reportcard.html.erb',
	        	orientation: 'Landscape',
	        	page_size: 'A3',
	        	window_status: "FLAG_FOR_PDF",
	        	dpi: '300',
	        	show_as_html: params.key?('debug'),
	        	margin:  { 
	        		top:               10,                     
	                bottom:            5,
	                left:              5,
	                right:             5}
		      end
			end
		end
	end

	private


	def student_params
   	params.require(:student).permit(:search, :lastfirst, :student_number, :gradelevel)
  end
end
