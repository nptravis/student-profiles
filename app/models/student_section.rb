class StudentSection < ApplicationRecord
	belongs_to :student 
	belongs_to :section

	validates :student_id, :section_id, presence: true
end