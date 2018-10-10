file = File.read('data/all-quarter-comments.json')

data_hash = JSON.parse(file)
i = 0;
data_hash.each do |set|

	student = Student.find_by(dcid: set["student_dcid"])
	section = Section.find_by(dcid: set["section_dcid"])
	teacher = Teacher.find_by(dcid: set["teacher_dcid"])

	quarter_comment = QuarterComment.find_or_initialize_by(
		teacher_id: teacher.id,
		student_id: student.id,
		section_id: section.id
		)

	quarter_comment.content = set["content"]

	if quarter_comment.save
		puts "Record saved #{i}"
		i+=1
		
	else
		puts "ERROR: something not found"
		puts "Section dcid: #{set['section_dcid']}"
		puts "student dcid: #{set['student_dcid']}"
		puts "teacher dcid: #{set['teacher_dcid']}"
		break
	end


end