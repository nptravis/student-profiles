Dir[File.join(Rails.root, 'db', 'seeds', 'student_ids.rb')].sort.each do |seed|
  load seed
end

