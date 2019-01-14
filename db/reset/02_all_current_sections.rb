file = File.read('data/all-current-sections.json')

data_hash = JSON.parse(file)
data_hash.each_with_index do |set, index|

	school = School.find_or_initialize_by(
		number: set["schoolid"]
		)
	
	case school.number
	when 101
		school.name = "RIS High School"
	when 102
		school.name = "RIS Middle School"
	when 103
		school.name = "RIS Elementary School"
	end


	school.abbreviation = set["abbreviation"]

	if !school.save
		puts "ERROR: school not saved"
		puts "school id #{set['schoolid']}"
		break
	end

	teacher = Teacher.find_or_initialize_by(
		email: set["email_addr"],
		lastfirst: set["teacher_lastfirst"],
		dcid: set["teacher_dcid"],
		teacher_number: set["teachernumber"]
		)

	teacher.ps_id = set["teacher_ps_id"]

	if !teacher.save
		puts "ERROR: teacher not saved"
		puts "teacher dcid #{set['teacher_dcid']}"
		break
	end

	student = Student.find_or_initialize_by(
		lastfirst: set["lastfirst"], 
		student_number: set["student_number"], 
		dcid: set["student_dcid"],
		ps_id: set["student_ps_id"]
		)

	student.school = school
	student.grade_level = set["grade_level"]
	student.email = set["ris_stu_email"]
	student.mailing_city = set["mailing_city"]
	student.mailing_street_1 = set["mailing_street"]
	student.mailing_street_2 = set["ris_mailing_street_2"]
	student.guardian_names = set["ris_parent_guardian"]
	student.mailing_state = set["mailing_state"]
	student.mailing_zip = set["mailing_zip"]
	student.home_room = set["home_room"]

	if !student.save
		puts "ERROR: student not saved"
		puts "student dcid #{set['student_dcid']}"
		binding.pry
		break
	end

	term = Term.find_or_initialize_by(
		term_code: set["termid"])

	if !term.save
		puts "ERROR: term not saved"
		puts "term code #{set['termid']}"
		binding.pry
		break
	end

	course = Course.find_or_initialize_by(
		course_name: set["course_name"], 
		course_number: set["course_number"],
		dcid: set["course_dcid"],
		school_id: school.id
		)

	if !course.save
		puts "ERROR: course not saved"
		puts "course dcid #{set['course_dcid']}"
		binding.pry
		break
	else
		if !course.terms.include?(term)
			course.terms << term
		end
	end

	section = Section.find_or_initialize_by(
		course_id: course.id,
		section_number: set["section_number"],
		dcid: set["section_dcid"],
		term_id: term.id,
		grade_level: set["section_grade_level"]
		)

	section.teacher = teacher 
	section.expression = set["expression"]
	section.room = set["room"]

	if !section.save
		puts "ERROR: section not saved"
		puts "section dcid #{set['section_dcid']}"
		binding.pry
		break
	else
		if !student.sections.include?(section)
			student.sections << section
		end
	end

	puts "Section Record Saved #{index} out of #{data_hash.length - 1}"

end
