

file = File.read('data/all-attendance-data.json')

data_hash = JSON.parse(file)
data_hash.each_with_index do |set, index|


	section = Section.find_by(dcid: set["sectionid"])
	student = Student.find_by(ps_id: set["studentid"])

	if section.present? && student.present?
		attendance = Attendance.find_or_initialize_by(
				student_id: student.id,
				section_id: section.id,
				)

		attendance.absences = set["currentabsences"]
		attendance.tardies = set["currenttardies"]

		if !attendance.save
			puts "ERROR: attendance not saved"
			break
		end

		puts "Attedance Record Saved #{index} out of #{data_hash.length-1}"
	else 
		puts "section or student not found"
	end


end
