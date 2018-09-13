file = File.read('data/add-grade_level-to-sections.json')

data_hash = JSON.parse(file)
i = 0;

data_hash["items"].each do |set|

	section = Section.find_by(dcid: set["dcid"])

	if section.present?

		section.grade_level = set["grade_level"]

		if section.save
			puts "Record saved #{i}"
			i+=1
		else
			puts "ERROR: section not saved"
			break;
		end
	else
		puts "ERROR: section not found"
		puts "Section DCID = #{set["dcid"]}"
		break
	end

end