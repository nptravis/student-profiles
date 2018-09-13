Dir[File.join(Rails.root, 'db', 'seeds', 'add_grade_level_to_sections.rb')].sort.each do |seed|
  load seed
end

