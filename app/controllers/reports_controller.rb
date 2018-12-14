class ReportsController < ApplicationController

	def index
	end

	def q1_report_cards
		pdfs = CombinePDF.new
		students = Student.order(:grade_level, :lastfirst)
		
		students.each do |student| 
			@student = student
			html_string = render_to_string('students/reportcard.html.erb', layout: 'pdf.html.erb')
			pdf = WickedPdf.new.pdf_from_string(html_string, dpi: '300')
			pdfs << CombinePDF.parse(pdf)
		end

		pdfs.save 'q1-report-cards.pdf'
		send_data pdfs.to_pdf, filename: "q1-report-cards.pdf", type: "application/pdf", disposition: 'inline'
	end

	def ms_report_cards
		pdfs = CombinePDF.new
		students = Student.ms_students.order(:grade_level, :lastfirst)
		
		students.each do |student| 
			@student = student
			@sections = @student.ms_reporting_sections(2801)
			html_string = render_to_string('students/sem1_reportcard.html.erb',
				 layout: 'sem1_report_card.html.erb')
			pdf = WickedPdf.new.pdf_from_string(html_string, 
				dpi: '300',
				orientation: 'Landscape',
				page_size: 'A3',
				margin: { 
	        		top:               10,                     
	                bottom:            5,
	                left:              5,
	                right:             5}
				)
			pdfs << CombinePDF.parse(pdf)
		end

		pdfs.save 'ms-sem1-report-cards.pdf'
		send_data pdfs.to_pdf, filename: "ms-sem1-report-cards-all.pdf", type: "application/pdf", disposition: 'attachment'

	end

	def hs_report_cards
		pdfs = CombinePDF.new
		students = Student.hs_students.order(:grade_level, :lastfirst).limit(2)

		students.each do |student| 
			@student = student
			@sections = @student.hs_reporting_sections(2801)
			html_string = render_to_string('students/hs_sem1_reportcard.html.erb',
				 layout: 'sem1_report_card.html.erb')
			pdf = WickedPdf.new.pdf_from_string(html_string, 
				dpi: '300',
				orientation: 'Landscape',
				page_size: 'A3',
				margin:  { 
	        		top:               10,                     
	                bottom:            5,
	                left:              5,
	                right:             5}
				)
			pdfs << CombinePDF.parse(pdf)
		end

		pdfs.save 'hs-sem1-report-cards.pdf'
		send_data pdfs.to_pdf, filename: "hs-sem1-report-cards.pdf", type: "application/pdf", disposition: 'inline'

	end

	def es_report_cards
		pdfs = CombinePDF.new
		
		if params[:homeroom]
			section = Section.find(params[:homeroom])
			students = Student.es_students.by_home_room(section)
		else
			students = Student.es_students.k_and_up.order(:grade_level, :lastfirst).limit(2)
		end

		students.each do |student| 
			@student = student
			@sections = @student.es_reporting_sections(2801)
			html_string = render_to_string('students/es_sem1_reportcard.html.erb',
				 layout: 'sem1_report_card.html.erb')
			pdf = WickedPdf.new.pdf_from_string(html_string, 
				dpi: '300',
				orientation: 'Landscape',
				page_size: 'A3',
				margin:  { 
	        		top:               10,                     
	                bottom:            5,
	                left:              5,
	                right:             5}
				)
			pdfs << CombinePDF.parse(pdf)
		end

		pdfs.save 'es-sem1-report-cards.pdf'
		send_data pdfs.to_pdf, 
		filename: section.present? ? "es-sem1-report-cards-#{section.teacher.lastfirst}.pdf" : "all-es-sem1-report-cards.pdf", 
		type: "application/pdf", 
		disposition: 'attachment'

	end
end

