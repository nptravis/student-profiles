file = File.read('data/all-semester-comments.json')

data_hash = JSON.parse(file)
i = 0;
data_hash["items"].each do |set|

	teacher = Teacher.find_by(dcid: set["teacher_dcid"])
	section = Section.find_by(dcid: set["section_dcid"])
	student = Student.find_by(dcid: set["student_dcid"])

	if teacher.present? && section.present? && student.present?
		semester_comment = SemesterComment.find_or_initialize_by(
			:content => set["commentvalue"],
			:semester => set["storecode"],
			:teacher_id => teacher.id,
			:section_id => section.id,
			:student_id => student.id
			)
		if semester_comment.save
			puts "Record saved #{i}"
			i+=1
		else
			puts "ERROR: semester_comment not saved"
			break;
		end
	else
		puts "ERROR: can't find teacher or section or student"
		puts "Teacher DCID = #{set["teacher_dcid"]}"
		puts "Student DCID = #{set["student_dcid"]}"
		puts "Section DCID = #{set["section_dcid"]}"
		break;
	end
end