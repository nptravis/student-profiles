class Term < ApplicationRecord
	has_many :standard_terms
	has_many :standards, through: :standard_terms
	has_many :course_terms
	has_many :courses, through: :course_terms
	has_many :trad_grades

	validates :term_code, presence: true
end 