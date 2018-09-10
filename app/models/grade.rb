class Grade < ActiveRecord::Base
	belongs_to :standard
	belongs_to :student
	belongs_to :section
	validates :standard_id, :section_id, :student_id, :grade, :semester, :termid, presence: true

	
end
