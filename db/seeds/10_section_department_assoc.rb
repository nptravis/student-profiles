file = File.read('data/all-section-department-assoc.json')

data_hash = JSON.parse(file)

data_hash.each_with_index do |set, index|

	course = Course.find_by(dcid: set['course_dcid'])
	school = School.find_by(number: set['schoolid'])

	if course.school === school
		department = Department.where(dcid: set['department_dcid']).first_or_create do |dep|

			dep.dcid =  set['department_dcid']
			dep.name = set['sched_department']
			dep.ps_id = set['ps_id']
			dep.school_id = school.id
		end


		if department.id && course.present? && course.school === school
			course.department = department
			course.save
			
			puts "Department Record Saved #{index} out of #{data_hash.length-1}"
		else
			binding.pry
		end
	end

end

# {"schoolid":101,"course_dcid":1603,"sched_department":"ELECTIVES","section_dcid":33857,"ps_id":55,"department_dcid":55}