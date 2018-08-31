
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
		course_number: set["course_number"])

	teacher = Teacher.find_or_initialize_by(
		email: set["email_addr"],
		name: set["lastfirst_1"]
		)

	if student.save && standard.save && course.save && teacher.save

		section = Section.find_or_initialize_by(
			course_id: course.id,
			teacher_id: teacher.id,
			course_number: set["course_number"],
			course_name: set["course_name"],
			semester: set["storecode"],
			section_number: set["section_number"]
			)

		section.save

		student_section = StudentSection.find_or_initialize_by(
			student_id: student.id,
			section_id: section.id
			)

		course_standard = CourseStandard.find_or_initialize_by(
			course_id: course.id,
			standard_id: standard.id
			)
		
	else
		puts "ERROR: something other than section didn't save"
	end


	if student_section.save && course_standard.save

		grade = Grade.new(
			standard_id: standard.id, 
			student_id: student.id, 
			grade: set["standardgrade"] 
			)

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
			break;
		end

	else
		puts "ERROR: Section not saved."
		binding.pry
		break;
	end

end