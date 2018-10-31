class Grade < ActiveRecord::Base
	belongs_to :standard
	belongs_to :student
	belongs_to :section
	belongs_to :term
	validates :standard_id, :section_id, :student_id, :grade, :semester, :term_id, presence: true

	def self.grades_per_standard(standard)
		standard.grades
	end

	def letter_grade
		case self.grade
		when "4"
			"E"
		when "3"
			"M"
		when "2"
			"P"
		when "1"
			"B"
		else
			"N"
		end
	end

	def pe?
		self.section.course.course_number.start_with?("PE")
	end

	def pe_standard_name
		self.standard.standard_name.scan(/.+[-]/)[0].chomp(" -")
	end

end

