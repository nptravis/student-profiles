file = File.read('data/es-attendance.json')

data_hash = JSON.parse(file)

data_hash.each_with_index do |set, index|

	student = Student.find_by(dcid: set["DCID"])
	section = student.es_homeroom

	if student.present? && section.present?

		attendance = Attendance.find_or_initialize_by(
			student_id: student.id,
			section_id: section.id
			)

		attendance.tardies = set["tardies"]
		attendance.absences = set["absences"]

		if !attendance.save
			puts "ERROR: Attendance not saved"
			binding.pry
			break
		end

		student.alert = set["alert"]

		if !student.save
			puts "ERROR: Student Alert not saved"
			binding.pry
			break
		end

		puts "ES Attendance Saved #{index} of #{data_hash.length-1}"
	end

end
