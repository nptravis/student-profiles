file = File.read('data/all-final-standards-17_18-to-now.json')

data_hash = JSON.parse(file)
i = 0;
data_hash["items"].each do |set|

	student = Student.find_by(dcid: set["student_dcid"])
	section = Section.find_by(dcid: set["section_dcid"])
	course = Course.find_by(dcid: set["course_dcid"])

	if student.present? && section.present? && course.present?

		standard = Standard.find_or_initialize_by(
			standard_name: set["name"], 
			identifier: set["identifier"],
			dcid: set["standard_dcid"]
			)

		standard.save

		standard_course = CourseStandard.find_or_initialize_by(
			standard_id: standard.id,
			course_id: course.id
			)

		if standard_course.save

			grade = Grade.find_or_initialize_by(
				standard_id: standard.id, 
				student_id: student.id, 
				section_id: section.id,
				grade: set["standardgrade"],
				termid: set["termid"]
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
			puts "ERROR: standard not saved"
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