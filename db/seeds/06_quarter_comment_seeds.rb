file = File.read('data/all-quarter-comments.json')

data_hash = JSON.parse(file)
data_hash.each_with_index do |set, index|

	student = Student.find_by(dcid: set["student_dcid"])
	section = Section.find_by(dcid: set["section_dcid"])
	teacher = Teacher.find_by(dcid: set["teacher_dcid"])
	
	if student.present? && teacher.present? && section.present?
		quarter_comment = QuarterComment.find_or_initialize_by(
			teacher_id: teacher.id,
			student_id: student.id,
			section_id: section.id
			)

		quarter_comment.content = set["content"]

		if quarter_comment.save
			puts "Quarter Comment Record saved #{index} out of #{data_hash.length-1}"
		else
			puts "ERROR: quarter comment not saved"
			binding.pry
			break
		end
	else
		puts "ERROR: something not found"
		binding.pry
		break
	end


end