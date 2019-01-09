file = File.read('data/all-hs-trad-grades.json')

data_hash = JSON.parse(file)

data_hash.each_with_index do |set, index|
	
	school = School.find_by(number: 101)
	student = Student.find_by(dcid: set["student_dcid"])
	section = Section.find_by(dcid: set["section_dcid"])
	term = Term.find_by(term_code: set["termid"])
	

	if student.present? && section.present? && term.present? && section.teacher.present? && school.present?

		if section.course.course_name.include?("Advisory")
			semester_comment = SemesterComment.find_or_initialize_by(
				:semester => set["storecode"],
				:teacher_id => section.teacher.id,
				:section_id => section.id,
				:student_id => student.id
				)

			semester_comment.content = set["comment_value"]

			if !semester_comment.save
				puts "ERROR: Semester Comment not saved"
				binding.pry
				break           
			end
			# binding.pry
		else
			grade = TradGrade.find_or_initialize_by(
				student_id: student.id, 
				section_id: section.id,
				term_id: term.id,
				semester: set["storecode"]
				)

			grade.grade = set["grade"]
			grade.percent = set["percent"]

			if !grade.save
				puts "ERROR: Grade not saved."
				binding.pry
				break             
			end

		end

		attendance = Attendance.find_or_initialize_by(
			section_id: section.id,
			student_id: student.id
			)

		attendance.absences = set["absences"]
		attendance.tardies = set["tardies"]

		if !attendance.save
			puts "ERROR: Attendance not saved"
			binding.pry
			break
		end

		puts "Trad Grade Record Saved #{index} out of #{data_hash.length-1}"

	else
		puts "ERROR: student or section or course or term or school not found."
		puts "Course DCID: #{set["course_dcid"]}"
		puts "Student DCID: #{set["student_dcid"]}"
		puts "Section DCID: #{set["section_dcid"]}"
		binding.pry
		break;
	end
end