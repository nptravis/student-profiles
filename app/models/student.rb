class Student < ActiveRecord::Base
	has_many :comments
	has_many :users, through: :comments
	has_many :grades
	has_many :standards, through: :grades
	has_many :courses, through: :grades
	validates :lastfirst, :student_number, :gradelevel, presence: true
	validates_uniqueness_of :student_number

	def uniq_courses
		self.courses.uniq
	end

	def self.search(word)
  	if word.present?
  		self.all.where('lastfirst LIKE ?', "%#{word}%")
  	else
  		self.all
  	end
  end

	def grades_per_semester(semester)
		self.grades.where("semester = ?", semester)
	end

	def grades_per_semester_per_course(semester, course)
		self.grades_per_semester(semester).where("course_id = ?", course.id)
	end

	def homs_per_semester_per_course(semester, course)
		arr = {}
		self.grades_per_semester_per_course(semester, course).each do |grade|
			if grade.standard.hom?
				arr[grade.standard.standard_name] = grade.grade
			end
		end
		arr
	end

	def standards_per_semester_per_course(semester, course)
		arr = {}
		self.grades_per_semester_per_course(semester, course).each do |grade|
			if !grade.standard.hom?
				arr[grade.standard.standard_name] = grade.grade
			end
		end
		arr
	end

end