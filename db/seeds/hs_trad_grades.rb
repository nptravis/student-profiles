file = File.read('data/all-hs-trad-grades.json')

data_hash = JSON.parse(file)
i = 0;
data_hash.each do |set|
	
	school = School.find_by(number: 101)
	student = Student.find_by(dcid: set["student_dcid"])
	section = Section.find_by(dcid: set["section_dcid"])
	term = Term.find_by(term_code: set["termid"])

	section.absences = set["absences"]

	if student.present? && section.save && term.present?

		grade = TradGrade.find_or_initialize_by(
			student_id: student.id, 
			section_id: section.id,
			term_id: term.id,
			semester: set["storecode"]
			)

		grade.grade = set["grade"]
		grade.percent = set["percent"]

		# case grade.grade
		# 	when "E"
		# 		grade.grade = 4
		# 	when "M"
		# 		grade.grade = 3
		# 	when "P"
		# 		grade.grade = 2
		# 	when "B"
		# 		grade.grade = 1
		# 	else
		# 		grade.grade = 0
		# end

		if section.course.course_name.include?("Advisory")
			semester_comment = SemesterComment.find_or_initialize_by(
				:semester => set["storecode"],
				:teacher_id => section.teacher.id,
				:section_id => section.id,
				:student_id => student.id
				)

			semester_comment.content = set["commentvalue"]
			if semester_comment.save
				puts "SemesterComment Saved"
			else
				puts "ERROR: Semester Comment not saved"
				break;
			end
		end

		if grade.save
			puts "Record saved #{i}"
			i+=1
		else
			puts "ERROR: Grade not saved."
			break;
		end

	else
		puts "ERROR: student or section or course not found."
		puts "Course DCID: #{set["course_dcid"]}"
		puts "Student DCID: #{set["student_dcid"]}"
		puts "Section DCID: #{set["section_dcid"]}"
		break;
	end
end