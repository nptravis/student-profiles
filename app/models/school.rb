class School < ApplicationRecord
	has_many :students
	has_many :courses

	validates :number, :name, :abbreviation, :address, presence: true
end
