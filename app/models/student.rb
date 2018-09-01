class Student < ActiveRecord::Base
	has_many :comments
	has_many :users, through: :comments
	has_many :student_sections
	has_many :sections, through: :student_sections
	has_many :grades
	has_many :teachers, through: :sections
	has_many :courses, through: :sections
	has_many :standards, through: :grades
	validates :lastfirst, :student_number, :gradelevel, presence: true
	validates_uniqueness_of :student_number

	def self.search(word)
	  	if word.present?
	  		self.all.where('lastfirst LIKE ?', "%#{word}%")
	  	else
	  		self.all
	  	end
	end

	# YESSSSSS!!!!!!SSSSSSS!!!!!!!! I think this is it.
	def grades_per_semester_per_section(semester, section)
		self.grades.where("semester = ? AND section_id = ?", semester, section.id);
	end

	def homs_per_semester_per_section(semester, section)
		arr = {}
		self.grades_per_semester_per_section(semester, section).each do |grade|
			if grade.standard.hom?
				arr[grade.standard.standard_name] = grade.grade
			end
		end
		arr
	end

	def standards_per_semester_per_section(semester, section)
		arr = {}
		self.grades_per_semester_per_section(semester, section).each do |grade|
			if !grade.standard.hom?
				arr[grade.standard.standard_name] = grade.grade
			end
		end
		arr
	end

end