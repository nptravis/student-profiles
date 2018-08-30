
# ///////// Simple data
file = File.read('data/all-final-standards.json')
# file = File.read('data/data.json')
data_hash = JSON.parse(file)
i = 0;
data_hash["items"].each do |set|
	
	student = Student.find_or_initialize_by(
		lastfirst: set["lastfirst"], 
		student_number: set["student_number"], 
		gradelevel: set["grade_level"])
	
	standard = Standard.find_or_initialize_by(
		standard_name: set["name"], 
		identifier: set["identifier"])

	course = Course.find_or_initialize_by(
		course_name: set["course_name"], 
		course_number: set["course_number"],
		section: set["section_number"],
		teacher_email: set["email_addr"])

	if student.save && standard.save && course.save

		grade = Grade.new(
			course_id: course.id, 
			standard_id: standard.id, 
			student_id: student.id, 
			grade: set["standardgrade"],  
			semester: set["storecode"])

		case grade.grade
			when "E"
				grade.grade = 4
			when "M"
				grade.grade = 3
			when "P"
				grade.grade = 2
			when "B"
				grade.grade = 1
			else
				grade.grade = 0
		end

		if grade.save
			puts "Record saved #{i}"
			i+=1
		else
			puts "ERROR: Grade not saved."
		end

	else
		puts "ERROR: Record not saved."
	end

end