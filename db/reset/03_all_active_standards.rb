file = File.read('data/all-active-standards.json')

data_hash = JSON.parse(file)
data_hash.each_with_index do |set, index|

	course = Course.find_by(dcid: set["course_dcid"])

	if course.present?
		standard = Standard.find_or_initialize_by(
			dcid: set["standardid"],
			identifier: set["identifier"]
			)

		standard.description = set["description"]
		standard.standard_name = set["name"]
		standard.parent_standard_dcid = set["parentstandardid"]

		if !standard.save
			puts "ERROR: Standard not saved"
			binding.pry
			break
		end

		(course.standards.find_by(id: standard.id) || course.standards << standard)
	else
		puts "ERROR: Course not found, keep calm, maybe course didn't end up running"
		puts "Course dcid: #{set['course_dcid']}"
		binding.pry
		break
	end

	puts "Standard Record Saved #{index} out of #{data_hash.length-1}"

end