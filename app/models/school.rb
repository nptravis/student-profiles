class School < ApplicationRecord
	has_many :students
	has_many :courses

	validates :number, :name, :abbreviation, presence: true

	def self.hs 
		where(number: 101)
	end

	def self.ms 
		where(number: 102)
	end

	def self.es 
		where(number: 103)[0]
	end

end
