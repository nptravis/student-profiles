class Student < ActiveRecord::Base
	has_many :grades
	has_many :standards, through: :grades
end