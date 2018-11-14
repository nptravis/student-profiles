# Dir[File.join(Rails.root, 'db', 'reset', '*.rb')].sort.each do |seed|
#   load seed
# end

Dir[File.join(Rails.root, 'db', 'seeds', '09_es_attendance.rb')].sort.each do |seed|
  load seed
end
