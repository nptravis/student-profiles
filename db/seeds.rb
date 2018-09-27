Dir[File.join(Rails.root, 'db', 'seeds', 'create_users.rb')].sort.each do |seed|
  load seed
end

