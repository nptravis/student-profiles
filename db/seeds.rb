Dir[File.join(Rails.root, 'db', 'seeds', 'sction_seeds.rb')].sort.each do |seed|
  load seed
end

