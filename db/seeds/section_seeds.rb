file = File.read('demo-data/A-all-sections-cj.json')

data_hash = JSON.parse(file)
i = 0;
data_hash["items"].each do |set|

	student = Student.find_or_initialize_by(
		lastfirst: set["lastfirst"], 
		student_number: set["student_number"], 
		grade_level: set["grade_level"],
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

	term = Term.find_or_initialize_by(
		term_code: set["termid"])

	if student.save && course.save && teacher.save && term.save

		section = Section.find_or_initialize_by(
			course_id: course.id,
			teacher_id: teacher.id,
			section_number: set["section_number"],
			expression: set["expression"],
			dcid: set["section_dcid"],
			term_id: term.id,
			room: set["room"],
			grade_level: set["section_grade_level"]
			)

		if section.save

			course_term = CourseTerm.find_or_initialize_by(
				term_id: term.id, course_id: course.id)
			student_section = StudentSection.find_or_initialize_by(
				student_id: student.id, section_id: section.id)
		else
			puts "ERROR: section did not save"
		end
		
		if student_section.save && course_term.save
			puts "Record saved #{i}"
			i+=1
		else
			puts "ERROR: section or course_term not saved: Course: #{section.course.course_name} Section: #{section.section_number}"
			break;
		end
	else
		puts "ERROR: student or course or teacher or term not saved!"
		break;
	end
end