file = File.read('data/transcript-data.json')

data_hash = JSON.parse(file)
i = 0;
data_hash.each do |set|

	student = Student.find_by(dcid: set["DCID"])
	transcript = Transcript.find_or_initialize_by(student_id: student.id)

	if student.present? && transcript.present?

		transcript.cumulative_gpa = set["gpa_cumulative"]
		transcript.g9_sem1_gpa = set["g9_sem1"]
		transcript.g9_sem2_gpa = set["g9_sem2"]
		transcript.g10_sem1_gpa = set["g10_sem1"]
		transcript.g10_sem2_gpa = set["g10_sem2"]
		transcript.g11_sem1_gpa = set["g11_sem1"]
		transcript.g11_sem2_gpa = set["g11_sem2"]
		transcript.g12_sem1_gpa = set["g12_sem1"]
		transcript.g12_sem2_gpa = set["g12_sem2"]
		transcript.eng_credit = set["eng_credit"]
		transcript.mat_credit = set["mat_credit"]
		transcript.sci_credit = set["sci_credit"]
		transcript.soc_credit = set["soc_credit"]
		transcript.mod_credit = set["mod_credit"]
		transcript.pe_credit = set["pe_credit"]
		transcript.arts_credit = set["arts_credit"]
		transcript.health_credit = set["health_credit"]
		transcript.rel_credit = set["rel_credit"]
		
		student.transcript = transcript
		
		if transcript.save
			puts "Record saved #{i}"
			i+=1
		else
			puts "ERROR: Transcript not saved"
			puts "Student Number: #{set['Student_Number']}"
			break;
		end
	else
		puts "ERROR: Student not found or Transcript not found or created"
		puts "Student Number: #{set['Student_Number']}"
		break;
	end

end
