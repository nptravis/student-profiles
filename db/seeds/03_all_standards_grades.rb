file = File.read('data/all-standards-grades.json')

data_hash = JSON.parse(file)
data_hash.each_with_index do |set, index|
	
	student = Student.find_by(dcid: set["student_dcid"])
	section = Section.find_by(dcid: set["section_dcid"])
	standard = Standard.find_by(dcid: set["standard_dcid"])
	term = section.term
	teacher = section.teacher
	

	if student.present? && section.present? && standard.present? && term.present? && teacher.present?

		if standard.standard_name.include?("Comment") || standard.identifier === "ESPOPs"

			semester_comment = SemesterComment.find_or_initialize_by(
			:semester => set["storecode"],
			:teacher_id => teacher.id,
			:section_id => section.id,
			:student_id => student.id
			)

			semester_comment.content = set["commentvalue"]

			if !semester_comment.save
				puts "ERROR: Semester Comment not saved."
				binding.pry
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

			if !grade.save
				puts "ERROR: grade not saved"
				puts "Standard id #{set['standardid']}"
				puts "Course DCID: #{set["course_dcid"]}"
				puts "Student DCID: #{set["student_dcid"]}"
				puts "Section DCID: #{set["section_dcid"]}"
				binding.pry
				break
			end

		end

		puts "Standard Grade Record Saved #{index} out of #{data_hash.length-1}"	
		
	else
		puts "ERROR: student or section or standard or term or teacher not found."
		puts "Student DCID: #{set["student_dcid"]}"
		puts "Section DCID: #{set["section_dcid"]}"
		puts "Standard DCID: #{set["standard_dcid"]}"
		binding.pry
		break
	end

end
