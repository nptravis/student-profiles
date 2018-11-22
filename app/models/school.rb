class School < ApplicationRecord
	has_many :students
	has_many :courses

	validates :number, :name, :abbreviation, presence: true

	def self.hs 
		select{|school| school.number === 101}[0]
	end

	def self.ms 
		select{|school| school.number === 102}[0]
	end

	def self.es 
		select{|school| school.number === 103}[0]
	end



end
