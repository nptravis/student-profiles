file = File.read('data/all-final-standards.json')

data_hash = JSON.parse(file)
i = 0;
data_hash["items"].each do |set|

	student = Student.find_by(dcid: set["student_dcid"])
	section = Section.find_by(dcid: set["section_dcid"])
	course = Course.find_by(dcid: set["course_dcid"])
	term = Term.find_by(term_code: set["termid"])

	if student.present? && section.present? && course.present? && term.present?

		standard = Standard.find_or_initialize_by(
			standard_name: set["name"], 
			identifier: set["identifier"],
			dcid: set["standard_dcid"]
			)

		if standard.save 

			standard_term = StandardTerm.find_or_initialize_by(
				standard_id: standard.id,
				term_id: term.id)

			if course.standards.include?(standard)
				puts "standard already included in course standards"
			else
				course.standards << standard
			end 

		else
			puts "ERROR: term or standard not saved"
		end

		if standard_term.save

			grade = Grade.find_or_initialize_by(
				standard_id: standard.id, 
				student_id: student.id, 
				section_id: section.id,
				grade: set["standardgrade"],
				term_id: term.id,
				semester: set["storecode"]
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
			puts "ERROR: standard_term not saved"
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