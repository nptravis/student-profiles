file = File.read('data/hs-summer-school.json')

data_hash = JSON.parse(file)

data_hash.each_with_index do |set, index|

	# add teachers that left after summer school:
	Teacher.create(
		email: "walterk@rism.ac.th",
		lastfirst: "Koertge, Walter",
		dcid: 448,
		teacher_number: '1899',
		ps_id: 448
		)

	school = School.find_by(number: 101)
	student = Student.find_by(ps_id: set["student_ps_id"])
	term = Term.find_by(term_code: set["termid"])
	teacher = Teacher.where("lastfirst LIKE ?", "%#{set['teacher_name'][0..3]}%")[0]

	if teacher.present?
	
		if student.present? && school.present? && term.present? 
			course = Course.find_or_initialize_by(
				course_name: set["course_name"],
				course_number: set["course_number"],
				dcid: set["course_dcid"],
				school_id: school.id
				)

			if course.save

				section = Section.find_or_initialize_by(
					course_id: course.id,
					teacher_id: teacher.id,
					section_number: "SS",
					expression: "NA",
					dcid: 9999 + index,
					term_id: term.id,
					room: "SS",
					grade_level: set["grade_level"]
					)

				if section.save
					if !student.sections.include?(section)
						student.sections << section
						attendance = Attendance.find_or_initialize_by(
							student_id: student.id,
							section_id: section.id
							)

						attendance.absences = set["absences"]
						attendance.tardies = set["tardies"]
					end

					trad_grade = TradGrade.find_or_initialize_by(
					student_id: student.id,
					section_id: section.id,
					term_id: term.id,
					percent: set["percent"],
					semester: "SS"
					)

					trad_grade.grade = set["grade"]
					if trad_grade.save
						puts "Record Saved #{index} out of #{data_hash.length-1}"

					else
						puts "ERROR: Gradenot saved"
						binding.pry
						break
					end
				else
					puts "ERROR: SEction not saved"
					binding.pry
					break
				
				end
			end

		else
			puts "ERROR: Student or SChool or Term not found"
			puts set["student_dcid"]
			binding.pry
			break;
		end
	else
		puts "ERROR: teacher not found"
		puts set["teacher_name"][0..5]
		binding.pry
		break;
	end
end