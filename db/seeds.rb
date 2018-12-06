Dir[File.join(Rails.root, 'db', 'reset', '03_all_active_standards.rb')].sort.each do |seed|
  load seed
end

Dir[File.join(Rails.root, 'db', 'seeds', '03_all_standards_grades.rb')].sort.each do |seed|
  load seed
end

Dir[File.join(Rails.root, 'db', 'seeds', '09_es_attendance.rb')].sort.each do |seed|
  load seed
end