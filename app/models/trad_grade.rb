class TradGrade < ApplicationRecord
	belongs_to :student
	belongs_to :section 
	belongs_to :term 

	validates :section_id, :term_id, :semester, presence: true 

end
