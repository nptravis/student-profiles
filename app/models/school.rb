class School < ApplicationRecord
	has_many :students
	has_many :courses

	validates :number, :name, :abbreviation, presence: true
end
