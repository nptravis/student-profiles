Dir[File.join(Rails.root, 'db', 'seeds', 'semester_grades_and_comments.rb')].sort.each do |seed|
  load seed
end

