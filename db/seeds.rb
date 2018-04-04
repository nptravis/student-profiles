# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
file = File.read('data/data.json')
data_hash = JSON.parse(file)
data_hash["items"].each do |set|
	
	student = Student.find_by(dcid: set["studentsdcid"])
	standard = Standard.find_by(dcid: set["standardid"])
	
	if !student
		student = Student.create(lastfirst: set["lastfirst"], dcid: set["studentsdcid"], gradelevel: set["gradelevel"])
	end
	
	if !standard
		standard = Standard.create(dcid: set["standardid"], standardname: set["name"])
	end
	
	Grade.create(standard_id: standard.id, student_id: student.id, grade: set["standardgrade"], percent: set["standardpercent"])
	
end
