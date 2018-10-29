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
end


