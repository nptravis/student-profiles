class Mathify

	def self.sum_grades(array_of_grade_objects)
		sum = 0
		array_of_grade_objects.each do |grade|
			sum += grade.grade.to_i
		end
	end

end