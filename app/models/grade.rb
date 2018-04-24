class Grade < ActiveRecord::Base
	belongs_to :student
	belongs_to :standard
	belongs_to :course

end