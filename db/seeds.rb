Dir[File.join(Rails.root, 'db', 'seeds', 'all_student_address.rb')].sort.each do |seed|
  load seed
end

