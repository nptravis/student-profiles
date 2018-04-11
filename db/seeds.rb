
# ///////// Simple data
file = File.read('data/all-standards.json')
data_hash = JSON.parse(file)
data_hash["items"].each do |set|
	
	student = Student.find_by(dcid: set["studentsdcid"])
	standard = Standard.find_by(dcid: set["standardid"])
	
	if !student
		student = Student.create(lastfirst: set["lastfirst"], dcid: set["studentsdcid"], gradelevel: set["gradelevel"])
	end
	
	if !standard
		standard = Standard.create(dcid: set["standardid"], standardname: set["name"], identifier: set["identifier"])
	end
	
	Grade.create(standard_id: standard.id, student_id: student.id, grade: set["calculatedgrade"], store_code: set["storecode"], created_by: set["whocreated"])
	
end
