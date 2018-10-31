file = File.read('data/semester-grades-and-comments.json')

data_hash = JSON.parse(file)
i = 0;
data_hash.each do |set|

	student = Student.find_by(dcid: set["student_dcid"])
	standard = Standard.find_by(dcid: set["standard_dcid"])
	section = Section.find_by(dcid: set["section_dcid"])
	term = Term.find_by(term_code: 2801)
	teacher = section.teacher

	if student.present? && section.present? && teacher.present? && term.present? && standard.present?
		
		if standard.identifier === "MSSEMCOM"
			semester_comment = SemesterComment.find_or_initialize_by(
				:semester => set["storecode"],
				:teacher_id => teacher.id,
				:section_id => section.id,
				:student_id => student.id
				)
			semester_comment.content = set["commentvalue"]
			if semester_comment.save
				puts "Semester Comment Saved."
				i+=1
			else
				puts "Semester Comment Not Saved"
				break;
			end

		else

			grade = Grade.find_or_initialize_by(
						standard_id: standard.id, 
						student_id: student.id, 
						section_id: section.id,
						term_id: term.id,
						semester: set["storecode"]
						)
			grade.grade = set["standardgrade"]

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
				puts "ERROR: Grade OR Semester Comment not saved."
				break;
			end
		end
	else
		puts "Something not found"
		break;
	end

end