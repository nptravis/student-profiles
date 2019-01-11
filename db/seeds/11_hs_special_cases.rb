# Adding a W to a classes that were dropped to the report card

# term = Term.find_by(term_code: 2801)

# pun = Student.find_by(student_number: 17912)
# ib_thai = Section.find_by(dcid: 33250)


# pun.sections << ib_thai

# TradGrade.create(
# 	term_id: term.id,
# 	student_id: pun.id,
# 	section_id: ib_thai.id,
# 	grade: 'W',
# 	semester: 'S1'
# 	)

# stu2 = Student.find_by(student_number: 18411)
# sec2 = Section.find_by(dcid: 32986)


# stu2.sections << sec2

# TradGrade.create(
# 	term_id: term.id,
# 	student_id: stu2.id,
# 	section_id: sec2.id,
# 	grade: 'W',
# 	semester: 'S1'
# 	)


# st3 = Student.find_by(student_number: 16257)
# sec3 = Section.find_by(dcid: 32982)
# assoc = StudentSection.where(student_id: st3.id, section_id: sec3.id)[0]
# assoc.destroy

# stu4 = Student.find_by(student_number: 16488)
# new_math = Section.find_by(dcid: 33855)
# old_math = Section.find_by(dcid: 32959)
# # assoc1 = StudentSection.where(student_id: stu4.id, section_id: old_math.id)[0]
# # assoc1.destroy

# stu4.grades.where(section_id: old_math.id).each do |grade|
# 	grade.section = new_math
# 	grade.save
# end

# stu4.trad_grades.where(section_id: old_math.id).each do |grade|
# 	grade.section = new_math
# 	grade.save
# end
