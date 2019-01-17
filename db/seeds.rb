# Dir[File.join(Rails.root, 'db', 'reset', '02_all_current_sections.rb')].sort.each do |seed|
#   load seed
# end

# Dir[File.join(Rails.root, 'db', 'reset', '03_all_active_standards.rb')].sort.each do |seed|
#   load seed
# end

# Dir[File.join(Rails.root, 'db', 'seeds', '03_all_standards_grades.rb')].sort.each do |seed|
#   load seed
# end

Dir[File.join(Rails.root, 'db', 'seeds', '04_all_hs_trad_grades.rb')].sort.each do |seed|
  load seed
end

# Dir[File.join(Rails.root, 'db', 'seeds', '05_transcript_data.rb')].sort.each do |seed|
#   load seed
# end

# Dir[File.join(Rails.root, 'db', 'seeds', '07_attendance.rb')].sort.each do |seed|
#   load seed
# end

# Dir[File.join(Rails.root, 'db', 'seeds', '10_section_department_assoc.rb')].sort.each do |seed|
#   load seed
# end

# Dir[File.join(Rails.root, 'db', 'seeds', '11_hs_special_cases.rb')].sort.each do |seed|
#   load seed
# end