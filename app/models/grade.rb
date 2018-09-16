class Grade < ActiveRecord::Base
	belongs_to :standard
	belongs_to :student
	belongs_to :section
	belongs_to :term
	validates :standard_id, :section_id, :student_id, :grade, :semester, :term_id, presence: true

	def self.grades_per_standard(standard)
		standard.grades
	end
end

