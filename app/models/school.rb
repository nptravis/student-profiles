class School < ApplicationRecord
	has_many :students
	has_many :courses
	has_many :departments

	validates :number, :name, :abbreviation, presence: true

	def self.hs 
		find_by(number: 101)
	end

	def self.ms 
		find_by(number: 102)
	end

	def self.es 
		find_by(number: 103)
	end

end
