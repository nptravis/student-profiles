class SectionsController < ApplicationController

	def index
		@days = ["A", "B", "C", "D"]
		@periods = ["ADV", "P1", "P2", "P3", "FB", "P4", "P5"]
		@sections = Section.by_school(School.ms)
		@subjects = [
			{name: "Language Arts", abbr: "la"},
			{name: "Social Studies", abbr: "so"},
			{name: "Science", abbr: "sc"},
			{name: "Math", abbr: "ma"},
		]
		respond_to do |format|
			format.html  { render 'index' }
		    format.pdf do
	        	render pdf: "MS-master-schedule-2018-19", 
	        	# javascript_delay: 5000,
	        	layout: 'master_schedule_layout.html.erb',
	        	template: 'sections/index.html.erb',
	        	orientation: 'Landscape',
	        	page_size: 'A3',
	        	# window_status: "FLAG_FOR_PDF",
	        	dpi: '300',
	        	show_as_html: params.key?('debug'),
	        	margin:  { 
	        		top:               5,                     
	                bottom:            5,
	                left:              5,
	                right:             5}
	        end
	    end
	end

	def show
		@section = Section.find(params[:id])
	end

	def students
		section = Section.find(params[:id])
		@students = section.students
		render json: @students.to_json
	end

	def api_index
		@sections = Section.by_school(School.ms)
		render json: @sections, each_serializer: SectionSerializer
	end

end
