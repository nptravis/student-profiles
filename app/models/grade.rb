class Grade < ActiveRecord::Base
	belongs_to :standard
	belongs_to :student
	belongs_to :section
	belongs_to :term
	validates :standard_id, :section_id, :student_id, :grade, :semester, :term_id, presence: true

	def self.grades_per_standard(standard)
		standard.grades
	end

	def number_grade
		case self.grade
		when "E"
			4
		when "M"
			3
		when "P"
			2
		when "B"
			1
		else
			0
		end
	end

	def pe?
		self.section.course.course_number.start_with?("PE")
	end

	def pe_standard_name
		self.standard.standard_name.scan(/.+[-]/)[0].chomp(" -")
	end

end

