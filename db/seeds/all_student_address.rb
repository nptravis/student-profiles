
file = File.read('data/all-student-address.json')

data_hash = JSON.parse(file)
i = 0;
data_hash.each do |set|

	student = Student.find_by(dcid: set["student_dcid"])
	school = School.find_by(number: set["school_number"])
	
	if student.present? && school.present?
		student.mailing_city = set["mailing_city"]
		student.mailing_zip = set["mailing_zip"]
		student.mailing_state = set["mailing_state"]
		student.mailing_street_1 = set["mailing_street"]
		student.mailing_street_2 = set["ris_street_2"]
		student.email = set["ris_stu_email"]
		student.guardian_names = set["ris_parent_guardian"]
		student.school = school
	else
		puts "ERROR: Student or School not found"
		puts "Student DCID: #{set['student_dcid']}"
		break;
	end

	if student.save
		puts "Record Saved #{i}"
		i+=1
	else
		puts "ERROR: Student not saved"
		puts "Student DCID: #{set['student_dcid']}"
		break;
	end

end

