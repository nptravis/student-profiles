class Grade < ActiveRecord::Base
	belongs_to :standard
	belongs_to :student
	validates :standard_id, :student_id, :grade, presence: true

end
