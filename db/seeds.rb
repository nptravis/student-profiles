
# ///////// Simple data
file = File.read('data/all-standards.json')
# file = File.read('data/data.json')
data_hash = JSON.parse(file)
data_hash["items"].each do |set|
	
	student = Student.find_or_create_by(lastfirst: set["lastfirst"], dcid: set["studentsdcid"], student_number: set["student_number"], gradelevel: set["gradelevel"])

	standard = Standard.find_or_create_by(dcid: set["standardid"], standardname: set["name"], identifier: set["identifier"])

	course = Course.find_or_create_by(course_name: set["course_name"], course_number: set["course_number"])
	
	if standard.standardname != "Semester Comment"
		grade = Grade.new(course_id: course.id, standard_id: standard.id, student_id: student.id, grade: set["calculatedmostrecentscores"], modified: set["whenmodified"], semester: set["storecode"])

		if !grade.course.instructor
			grade.course.instructor = set["whocreated"]
		end

		case grade.grade
			when "E"
				grade.grade = 4
			when "M"
				grade.grade = 3
			when "P"
				grade.grade = 2
			when "B"
				grade.grade = 1
			when nil 
				grade.grade = 0
			else
				grade.grade = 0
		end

		grade.save
	end

	if grade.nil?
		puts "Error, nil grade"
	elsif standard.nil?
		puts "Error, nil standard"
	elsif student.nil?
		puts "Error, nil student"
	elsif course.nil?
		puts "Error, nil course"
	end
	
end