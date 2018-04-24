class Student < ActiveRecord::Base
	has_many :grades
	has_many :standards, through: :grades
	has_many :courses, through: :grades

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

	def grades_per_course(course)
		self.grades_per_semester("S1").where("course_id = ?", course.id)
	end

	def homs_per_course(course)
		arr = {}
		self.grades_per_course(course).each do |grade|
			if grade.standard.hom?
				arr[grade.standard.standardname] = grade.grade
			end
		end
		arr
	end

	def standards_per_course(course)
		arr = {}
		self.grades_per_course(course).each do |grade|
			if !grade.standard.hom?
				arr[grade.standard.standardname] = grade.grade
			end
		end
		arr
	end

end