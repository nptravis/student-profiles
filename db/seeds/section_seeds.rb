file = File.read('data/all-sections.json')

data_hash = JSON.parse(file)
i = 0;
data_hash["items"].each do |set|

	student = Student.find_or_initialize_by(
		lastfirst: set["lastfirst"], 
		student_number: set["student_number"], 
		gradelevel: set["grade_level"],
		dcid: set["student_dcid"]
		)

	course = Course.find_or_initialize_by(
		course_name: set["course_name"], 
		course_number: set["course_number"],
		dcid: set["course_dcid"]
		)

	teacher = Teacher.find_or_initialize_by(
		email: set["email_addr"],
		lastfirst: set["lastfirst_1"],
		dcid: set["teacher_dcid"],
		teacher_number: set["teachernumber"]
		)

	if student.save && course.save && teacher.save

		section = Section.find_or_initialize_by(
			course_id: course.id,
			teacher_id: teacher.id,
			course_number: set["course_number"],
			course_name: set["course_name"],
			section_number: set["section_number"],
			expression: set["expression"],
			dcid: set["section_dcid"],
			termid: set["termid"],
			room: set["room"]
			)

		section.save

		student_section = StudentSection.find_or_initialize_by(
			student_id: student.id,
			section_id: section.id
			)
		if student_section.save
			puts "Record saved #{i}"
			i+=1
		else
			puts "ERROR: section not saved: Course: #{section.course_name} Section: #{section.section_number}"
		end
	else
		puts "ERROR: student or course or teacher not saved!"
		break;
	end
end