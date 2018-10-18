class CollectionService

	def all_homs(collection)
		collection.select {|x| x.standard.hom?} 
	end

	def all_standards(collection)
		collection.select {|x| !x.standard.hom?} 
	end

	def grades_per_section_per_semester_per_student(section, semester, student)
		standards = {}
		homs = {}
		collection = [standards, homs]
		section.grades.where("student_id = ? and semester = ?", student.id, semester).each do |grade|
			if !grade.standard.hom?
				standards["#{grade.standard.standard_name}"] = grade.grade
			else
				homs["#{grade.standard.standard_name}"] = grade.grade
			end
		end
		collection = {standards: standards.sort.to_h, homs: homs.sort.to_h}
		collection
	end

	def create_grades_hash(grades)
		grades_hash = {
			E: grades.where("grade = ?", '4').select(:id, :grade, :term_id).joins(:section).select(:grade_level),
			M: grades.where("grade = ?", '3').select(:id, :grade, :term_id).joins(:section).select(:grade_level),
			P: grades.where("grade = ?", '2').select(:id, :grade, :term_id).joins(:section).select(:grade_level),
			B: grades.where("grade = ?", '1').select(:id, :grade, :term_id).joins(:section).select(:grade_level),
			N: grades.where("grade = ?", '0').select(:id, :grade, :term_id).joins(:section).select(:grade_level)
		}
	end

end