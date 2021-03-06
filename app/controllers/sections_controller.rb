class SectionsController < ApplicationController

	def index
		@days = ["A", "B", "C", "D"]
		@periods = ["ADV", "P1", "P2", "P3", "FB", "P4", "P5"]
		@sections = Section.by_school(School.ms)
		@courses = Course.by_school(School.ms).sort_by(&:course_name)
		@subjects = [
			{name: "Language Arts", abbr: "la"},
			{name: "Social Studies", abbr: "so"},
			{name: "Science", abbr: "sc"},
			{name: "Math", abbr: "ma"},
		]
		@departments = Department.where(school_id: School.ms.id)
		respond_to do |format|
			format.html  { render 'index' }
			format.json { render json: @sections, each_serializer: SectionSerializer}
		    format.pdf do
	        	render pdf: "MS-master-schedule-2018-19", 
	        	layout: 'master_schedule_layout.html.erb',
	        	template: 'sections/_master_schedule.html.erb',
	        	orientation: 'Landscape',
	        	page_size: 'A3',
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

	def cores
		@days = ["A", "B", "C", "D"]
		@periods = ["ADV", "P1", "P2", "P3", "FB", "P4", "P5"]
		@sections = Section.by_school(School.ms).select{|section| section.core?}
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
	        	layout: 'master_schedule_layout.html.erb',
	        	template: 'sections/_cores.html.erb',
	        	orientation: 'Landscape',
	        	page_size: 'A3',
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
		@students = section.students.order(:grade_level, :lastfirst)
		render json: @students.to_json
	end

	def api_index
		@sections = Section.by_school(School.ms)
		render json: @sections, each_serializer: SectionSerializer
	end

	def create
		# binding.pry
		@days = ["A", "B", "C", "D"]
		@periods = ["ADV", "P1", "P2", "P3", "FB", "P4", "P5"]
		@subjects = [
			{name: "Language Arts", abbr: "la"},
			{name: "Social Studies", abbr: "so"},
			{name: "Science", abbr: "sc"},
			{name: "Math", abbr: "ma"},
		]
		@courses = Course.by_school(School.ms).order(:course_name)
		@departments = Department.where(school_id: School.ms.id)
		
		if params[:courses]
			@sections = Section.where(course_id: params[:courses])
		elsif params[:department] != "" && params[:department]
			@sections = Section.select{|section| 
				if section.course.department
					section.course.department.id === params[:department].to_i
				else
					false
				end
			}
			if params[:grade_level] != ""
				@sections.select!{|section| section.grade_level.to_s.split("").include?(params[:grade_level]) }
			end
		else
			@sections = Section.by_school(School.ms)
		end
		respond_to do |format|
			format.html  { render 'index' }
		    format.pdf do
	        	render pdf: "MS-master-schedule-2018-19", 
	        	layout: 'master_schedule_layout.html.erb',
	        	template: 'sections/_master_schedule.html.erb',
	        	orientation: 'Landscape',
	        	page_size: 'A3',
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

end
